class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @time_now = Time.now.utc.at_midnight

    @event_data = Array.new
    @activity_data = Array.new
    @user.events.each do |event|
      if event.event_type == 3
        date_start = (event.activity_since.utc.to_f*1000.0).to_i
        date_end = (event.entered_at.utc.to_f*1000.0).to_i
        @activity_data.push({x: date_start, y: event.activity_type, name: ACTIVITY_TYPE[event.activity_type]})
        @activity_data.push({x: date_end, y: event.activity_type, name: ACTIVITY_TYPE[event.activity_type]})
      else
        date = (event.entered_at.utc.to_f*1000.0).to_i
        @event_data.push({x: date, y: (event.event_type+6), name: EVENT_TYPE[event.event_type]})
      end
    end


    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart( zoomType: 'x')
      f.title( text: @user.first_name + " " + @user.last_name + ' ' + 'activity and events')
      f.tooltip(
        useHTML: true,
        headerFormat: '<small>{point.key}</small><table>',
        pointFormat: "<tr><td style=\"color: {series.color}\">{series.name}: </td>" + "<td style=\"text-align: right\"><b>{point.y}</b></td></tr>",
        crosshairs: true,
      footerFormat: '</table>')

      f.yAxis(
        min: 0,
        max: 11,
        categories: [nil, "Steady", "Walking", "Biking", "Running", nil, "Pain", "Meal", "Medicine", "Activity Change", "Other"],
        minorGridLineWidth: 1,
        gridLineWidth: 1,
        alternateGridColor: nil,
        tickInterval: 1,
        minTickInterval: 1,
        tickmarkPlacement: 'on',
        plotBands: [{
                      from: 0,
                      to: 5,
                      color: 'rgba(68, 170, 213, 0.1)',
                      label: {
                        text: 'Activity',
                        style: {
                          color: '#606060'
                        }
                      }
                    }, {
                      from: 5,
                      to: 10,
                      color: 'rgba(0, 0, 0, 0)',
                      label: {
                        text: 'Event',
                        style: {
                          color: '#606060'
                        }
                      }
                    }
                    ]
      )
      f.xAxis type: 'datetime'

      f.series(type: 'line', :name=>'Activity', :data=>@activity_data,  pointStart: (@time_now.to_f*1000.0).to_i)
      f.series(type: 'scatter', :name=>'Event', :data=>@event_data,  pointStart: (@time_now.to_f*1000.0).to_i)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def chart_gen

  end

end
