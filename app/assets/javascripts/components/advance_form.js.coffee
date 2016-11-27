@SubmitInfoForm = React.createClass
    getInitialState: ->
        steps: 1
        serviceList: null #@props.services
        userInfo: null
        medicalInfo: null
        serviceInfo: null
        stepMenu: [
            {code: 1, img: @props.phase1, bigtext: 'Bước 1', smalltext: 'Tạo thông tin cá nhân'}
            {code: 2, img: @props.phase2, bigtext: 'Bước 2', smalltext: 'Tiền sử y tế'}
            {code: 3, img: @props.phase3, bigtext: 'Bước 3', smalltext: 'Đăng ký dịch vụ'}
            {code: 4, img: @props.phase4, bigtext: 'Bước 4', smalltext: 'Xác nhận đăng ký'}
        ]
    changesteps: (code) ->
        if @state.userInfo == null and code > 1
            @showtoast('Bạn phải hoàn thành bước 1 trước khi chuyển sang bước ' + code, 3)
        else if @state.medicalInfo == null and code > 2
            @showtoast('Bạn phải hoàn thành bước 2 trước khi chuyển sang bước ' + code, 3)
        else if @state.serviceInfo == null and code > 3
            @showtoast('Bạn phải hoàn thành bước 3 trước khi chuyển sang bước ' + code, 3)
        else
            @setState steps: code
    showtoast: (message,toasttype) ->
	    toastr.options =
            closeButton: true
            progressBar: true
            positionClass: 'toast-top-right'
            showMethod: 'slideDown'
            hideMethod: 'fadeOut'
            timeOut: 4000
        if toasttype == 1
            toastr.success message
        else if toasttype == 2
            toastr.info(message)
        else if toasttype == 3
            toastr.error(message)
        return
    phase1Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: null, phase: @state.steps
    phase2Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: null, phase: @state.steps
    phase3Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: null, phase: @state.steps
    phase4Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: null, phase: @state.steps
    render: ->
        switch @state.steps
            when 1
                @phase1Render()
            when 2
                @phase2Render()
            when 3
                @phase3Render()
            when 4
                @phase4Render()

#input: data.code, data.img, data.bigtext, data.smalltext, phase
#output: trigger - put data.code out
@phaseMenuChild = React.createClass   
    getInitialState: ->
        style: 1
    trigger: ->
        @props.trigger @props.data.code
    normalRender: ->
        if @props.data.code == @props.phase
            React.DOM.li className: 'list-item text-center active',
                React.DOM.a onClick: @trigger,
                    React.DOM.span className: 'item-icon',
                        React.DOM.img src: @props.data.img
                    React.DOM.span className: 'item-title', @props.data.bigtext
                    React.DOM.span className: 'item-desc', @props.data.smalltext
        else
            React.DOM.li className: 'list-item text-center',
                React.DOM.a onClick: @trigger,
                    React.DOM.span className: 'item-icon',
                        React.DOM.img src: @props.data.img
                    React.DOM.span className: 'item-title', @props.data.bigtext
                    React.DOM.span className: 'item-desc', @props.data.smalltext
    render: ->
        @normalRender()

#input: data = list of phase, phase
#output: trigger
@phaseMenu = React.createClass
    getInitialState: ->
        style: 1
    trigger: (code) ->
        @props.trigger code
    normalRender: ->
        React.DOM.div className: 'container container-overview',
            React.DOM.div className: 'inner-container',
                React.DOM.ul id: 'steplist', className: 'pricing--overview-list',
                    for record in @props.data
                        React.createElement phaseMenuChild, key:record.code, data: record, phase: @props.phase, trigger: @trigger
    render: ->
        @normalRender()

#input: phase, data if available
#output: trigger -> give valueOut and 1 formData that give image info
@phaseForm = React.createClass
    getInitialState: ->
        steps: @props.phase
    step1Render: ->
        React.DOM.div className: 'container',
            React.DOM.section id: 'new-user', className: 'm-l-r-auto',
                React.DOM.div className: 'row fill-white',
                    React.DOM.div className: 'panel-heading text-center',
                        React.DOM.h2 null, "Tạo thông tin cá nhân"
                    React.DOM.form id: 'user_info', onSubmit: @handleSubmit, autoComplete: 'off',
                        React.DOM.div className: 'col-md-6',
                            React.DOM.div className: 'panel-body',
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-user icon-fw',
                                        React.DOM.input id:'cname', placeholder: 'Họ và tên', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.cname != undefined
                                                    ""
                                                else
                                                    @props.data.cname
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-birthday-cake icon-fw'
                                        React.DOM.input id:'cname', placeholder: 'Ngày sinh - 31/03/2001', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.dob != null and @props.data.dob != undefined 
                                                    @props.data.dob
                                                else
                                                    ""
                                            else
                                                ""
                        React.DOM.div className: 'col-md-6',
                            React.DOM.div className: 'panel-body',
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-user icon-fw'
                                        if @props.data != null
                                            if @props.data.gender == 1
                                                React.DOM.select className: 'form-control', id: 'gender',
                                                    React.DOM.option value: 1, selected: 'selected', "Nam"
                                                    React.DOM.option value: 2, "Nữ"
                                            else
                                                React.DOM.select className: 'form-control', id: 'gender',
                                                    React.DOM.option value: 1, "Nam"
                                                    React.DOM.option value: 2, selected: 'selected', "Nữ"
                                        else
                                            React.DOM.select className: 'form-control', id: 'gender',
                                                React.DOM.option value: 0, selected: 'selected', "Giới tính"
                                                React.DOM.option value: 1, "Nam"
                                                React.DOM.option value: 2, "Nữ"
                        React.DOM.div className: 'col-md-3 pull-right',
                            React.DOM.button className: 'btn btn-lg btn-block btn-static-primary', type: 'submit', "Xác nhận"
                            React.DOM.div className: 'spacer20'
            React.DOM.div className: 'row',
                React.DOM.div className: 'spacer40'
    step2Render: ->
        React.DOM.div className: 'container', "step2"
    step3Render: ->
        React.DOM.div className: 'container', "step3"
    step4Render: ->
        React.DOM.div className: 'container', "step4"
    render: ->
        switch @state.steps
            when 1
                @step1Render()
            when 2
                @step2Render()
            when 3
                @step3Render()
            when 4
                @step4Render()
        

@demoform = React.createClass
    getInitialState: ->
      style: 1
    showtoast: (message,toasttype) ->
	    toastr.options =
        closeButton: true
        progressBar: true
        positionClass: 'toast-top-right'
        showMethod: 'slideDown'
        hideMethod: 'fadeOut'
        timeOut: 4000
      if toasttype == 1
        toastr.success message
      else if toasttype == 2
        toastr.info(message)
      else if toasttype == 3
        toastr.error(message)
      return
    handleSubmit: (e) ->
      e.preventDefault()
      formData = new FormData
      formData.append 'fname', $('#first_name').val().toLowerCase()
      formData.append 'lname', $('#last_name').val().toLowerCase()
      formData.append 'email', $('#email').val().toLowerCase()
      formData.append 'sname', $('#company').val().toLowerCase()
      formData.append 'pnumber', $('#phone').val().toLowerCase()
      $.ajax
        url: '/enterprise/demo'
        type: 'POST'
        data: formData
        async: false
        cache: false
        contentType: false
        processData: false
        error: ((result) ->
          @showtoast("Đăng ký demo thất bại, vui lòng thử lại",3)
          return
        ).bind(this)
        success: ((result) ->
          @showtoast('Yêu cầu của bạn sẽ được xem xét và giải quyết trong từ 3 đến 5 ngày',2)
          @showtoast('Chúc mừng ' + result.lname + ' ' + result.fname + ' đã đăng ký lên lịch demo thành công',1)
          return
        ).bind(this)
    FullRender: ->
      React.DOM.form id: 'schedule-demo', onSubmit: @handleSubmit, autoComplete: 'off',
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Tên'
          React.DOM.input className: 'form-control', id: 'first_name', placeholder: 'Tên'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Họ và đệm'
          React.DOM.input className: 'form-control', id: 'last_name', placeholder: 'Họ và đệm'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Email'
          React.DOM.input className: 'form-control', id: 'email', placeholder: 'Email'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Tên phòng khám'
          React.DOM.input className: 'form-control', id: 'company', placeholder: 'Tên phòng khám'
        React.DOM.div className: 'form-group',
          React.DOM.label null, 'Số điện thoại'
          React.DOM.input className: 'form-control', id: 'phone', placeholder: 'Số điện thoại'
        React.DOM.div className: 'spacer20'
        React.DOM.div className: 'form-group',
          React.DOM.button type: 'submit', className: 'btn btn-block btn-success', 'Đăng ký Demo'
    render: ->
      @FullRender()