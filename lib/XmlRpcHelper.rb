require "xmlrpc/client"
require "xmlrpc/create"

class XMLRPC::Client
  USER_AGENT = "UGW Server/4.3/1.0"
end

class XMLRPC::XMLWriter::Simple

  def pi(name, *params)
    "<?#{name} " + params.join(" ") + "?>"
  end

end

class XMLRPC::DateTime
  def as_json(options={})
    "#{year}-#{month}-#{day}T#{hour}:#{min}:#{sec}"
  end

  def test2
    'Test'
  end
end

class XMLRPC::Create

  def methodCall(name, *params)
    name = name.to_s

    if name !~ /[a-zA-Z0-9_.:\/]+/
      raise ArgumentError, "Wrong XML-RPC method-name"
    end

    parameter = params.collect do |param|
      @writer.ele("param", conv2value(param))
    end

    tree = @writer.document(
        @writer.pi("xml", 'version="1.0"', 'encoding="utf-8"'),
        @writer.ele("methodCall",
                    @writer.tag("methodName", name),
                    @writer.ele("params", *parameter)
        )
    )

    @writer.document_to_str(tree) + "\n"
  end

  def conv2value(param)

    val = case param
            when Fixnum, Bignum
              # XML-RPC's int is 32bit int, and Fixnum also may be beyond 32bit
              if Config::ENABLE_BIGINT
                @writer.tag("i4", param.to_s)
              else
                if param >= -(2**31) and param <= (2**31-1)
                  @writer.tag("i4", param.to_s)
                else
                  raise "Bignum is too big! Must be signed 32-bit integer!"
                end
              end
            when TrueClass, FalseClass
              @writer.tag("boolean", param ? "1" : "0")

            when Symbol
              @writer.tag("string", param.to_s)

            when String
              @writer.tag("string", param)

            when NilClass
              if Config::ENABLE_NIL_CREATE
                @writer.ele("nil")
              else
                raise "Wrong type NilClass. Not allowed!"
              end

            when Float
              @writer.tag("double", param.to_s)

            when Struct
              h = param.members.collect do |key|
                value = param[key]
                @writer.ele("member",
                            @writer.tag("name", key.to_s),
                            conv2value(value)
                )
              end

              @writer.ele("struct", *h)

            when Hash
              # TODO: can a Hash be empty?

              h = param.collect do |key, value|
                @writer.ele("member",
                            @writer.tag("name", key.to_s),
                            conv2value(value)
                )
              end

              @writer.ele("struct", *h)

            when Array
              # TODO: can an Array be empty?
              a = param.collect {|v| conv2value(v) }

              @writer.ele("array",
                          @writer.ele("data", *a)
              )

            when Time, Date, ::DateTime
              @writer.tag("dateTime.iso8601", param.strftime("%Y%m%dT%H:%M:%S%z"))

            when XMLRPC::DateTime
              @writer.tag("dateTime.iso8601",
                          format("%.4d%02d%02dT%02d:%02d:%02d", *param.to_a))

            when XMLRPC::Base64
              @writer.tag("base64", param.encoded)

            else
              if Config::ENABLE_MARSHALLING and param.class.included_modules.include? XMLRPC::Marshallable
                # convert Ruby object into Hash
                ret = {"___class___" => param.class.name}
                param.instance_variables.each {|v|
                  name = v[1..-1]
                  val = param.instance_variable_get(v)

                  if val.nil?
                    ret[name] = val if Config::ENABLE_NIL_CREATE
                  else
                    ret[name] = val
                  end
                }
                return conv2value(ret)
              else
                ok, pa = wrong_type(param)
                if ok
                  return conv2value(pa)
                else
                  raise "Wrong type!"
                end
              end
          end

    @writer.ele("value", val)
  end

end
