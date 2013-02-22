class Admin::NodesController < Backend::SecureController

  def index
    @title = 'Nodes'
    @nodes = Node.paginate(:page => params[:page])
  end

  def show
  end

  def edit
    nodeId = params[:id]
    @node = Node.find( nodeId )
    @title = "Edit #{@node.name}"
    store_location
  end

  def new
    @title = 'Add Node'
    @node = Node.new
  end

  def update
    nodeId = params[:id]
    @node = Node.find( nodeId )

    nodep = params[:node]

    @node.name = nodep[ :name ]
    @node.ip = nodep[ :ip ]
    @node.klass = nodep[ :klass ]
    @node.port = nodep[ :port ]
    @node.port2 = nodep[ :port2 ]
    @node.port3 = nodep[ :port3 ]
    @node.port4 = nodep[ :port4 ]
    @node.active = nodep[ :active ]

    @node.user = nodep[ :user ]
    if !nodep[ :pass ].blank?
      @node.pass = nodep[ :pass ]
      @node.pass_confirmation = nodep[ :pass_confirmation ]
    end

    @node.user2 = nodep[ :user2 ]
    if !nodep[ :pass2 ].blank?
      @node.pass2 = nodep[ :pass2 ]
      @node.pass2_confirmation = nodep[ :pass2_confirmation ]
    end

    @node.user3 = nodep[ :user3 ]
    if !nodep[ :pass3 ].blank?
      @node.pass3 = nodep[ :pass3 ]
      @node.pass3_confirmation = nodep[ :pass3_confirmation ]
    end

    @node.user4 = nodep[ :user4 ]
    if !nodep[ :pass4 ].blank?
      @node.pass4 = nodep[ :pass4 ]
      @node.pass4_confirmation = nodep[ :pass4_confirmation ]
    end

    Auditlog( self.class.name, nodep )

    if @node.save()
      flash[ :success ] = "#{@node.name} properties updated."
    else
      #flash[ :error ] = "Error in updating #{@node.name} properties."
      render :edit
      return
    end

    redirect_back_or admin_node_path
  end

  def create
    @node = Node.new

    param = params[ :node ]

    @node.name = param[ :name ]
    @node.ip = param[ :ip ]
    @node.klass = param[ :klass ]
    @node.serverModel = param[ :serverModel ]
    @node.active = param[ :active ]
    @node.port = param[ :port ]
    @node.port2 = param[ :port2 ]
    @node.port3 = param[ :port3 ]
    @node.port4 = param[ :port4 ]

    @node.user = param[ :user ]
    if !param[ :pass ].blank?
      @node.pass = param[ :pass ]
      @node.pass_confirmation = param[ :pass_confirmation ]
    end

    @node.user2 = param[ :user2 ]
    if !param[ :pass2 ].blank?
      @node.pass2 = param[ :pass2 ]
      @node.pass2_confirmation = param[ :pass2_confirmation ]
    end

    @node.user3 = param[ :user3 ]
    if !param[ :pass3 ].blank?
      @node.pass3 = param[ :pass3 ]
      @node.pass3_confirmation = param[ :pass3_confirmation ]
    end

    @node.user4 = param[ :user4 ]
    if !param[ :pass4 ].blank?
      @node.pass4 = param[ :pass4 ]
      @node.pass4_confirmation = param[ :pass4_confirmation ]
    end

    if @node.save
      flash[:success] = "#{@node.name} added successfully"
      redirect_to admin_nodes_path
    else
      @title = 'Add new node'
      render :new
    end

    Auditlog( self.class.name, param )

  end

  def destroy
    nodeId = params[:id]
    if nodeId
      n = Node.find( nodeId )
      n.destroy
      flash[:notice] = "#{n.name} deleted successfully"
    end
    redirect_to admin_nodes_path
  end
end
