@SubmitInfoForm = React.createClass
    getInitialState: ->
        steps: 4
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
    generateToken: ->
        text = ''
        possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        i = 0
        while i < 6
            text += possible.charAt(Math.floor(Math.random() * possible.length))
            i++
        text
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
    handleSubmit: (e) ->
        e.preventDefault()
        switch @props.phase
            when 1
                user_info: {
                    cname: $('#step-1-form #cname').val()
                    dob: $('#step-1-form #dob').val()
                    gender: $('#step-1-form #gender').val()
                    address: $('#step-1-form #address').val()
                    pnumber: $('#step-1-form #pnumber').val()
                    noid: $('#step-1-form #noid').val()
                    issue_date: $('#step-1-form #issue_date').val()
                    issue_place: $('#step-1-form #issue_place').val()
                    work_place: $('#step-1-form #work_place').val()
                }
                formData = new FormData
                if $('#step-1-form #avatar')[0].files[0] != undefined
                    formData.append 'avatar', $('#step-1-form #avatar')[0].files[0]
                @props.trigger user_info, formData
                return
            when 2
                medical_history: {
                    self_history: $('#step-1-form #self_history').val()
                    family_history: $('#step-1-form #family_history').val()
                    drug_history: $('#step-1-form #drug_history').val()
                }
                @props.trigger medical_history
    step1Render: ->
        React.DOM.div className: 'container animated fadeIn',
            React.DOM.section id: 'new-user', className: 'm900 m-l-r-auto',
                React.DOM.div className: 'row fill-white',
                    React.DOM.div className: 'panel-heading text-center',
                        React.DOM.h2 null, "Tạo thông tin cá nhân"
                    React.DOM.form id: 'step-1-form', onSubmit: @handleSubmit, autoComplete: 'off',
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
                                        React.DOM.input id:'dob', placeholder: 'Ngày sinh - 31/03/2001', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.dob != null and @props.data.dob != undefined 
                                                    @props.data.dob
                                                else
                                                    ""
                                            else
                                                ""
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
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-map icon-fw'
                                        React.DOM.input id:'address', placeholder: 'Địa chỉ', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.address != null and @props.data.address != undefined 
                                                    @props.data.address
                                                else
                                                    ""
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-mobile icon-fw'
                                        React.DOM.input id:'pnumber', placeholder: 'Số điện thoại', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.pnumber != null and @props.data.pnumber != undefined 
                                                    @props.data.pnumber
                                                else
                                                    ""
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-file-image-o icon-fw'
                                        React.DOM.input id:'avatar', placeholder: 'Ảnh đại diện', type: 'file', className: 'form-control'
                        React.DOM.div className: 'col-md-6',
                            React.DOM.div className: 'panel-body',
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-info icon-fw'
                                        React.DOM.input id:'noid', placeholder: 'Số CMTND', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.noid != null and @props.data.noid != undefined 
                                                    @props.data.noid
                                                else
                                                    ""
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-birthday-cake icon-fw'
                                        React.DOM.input id:'issue_date', placeholder: 'Ngày cấp - 31/03/2001', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.issue_date != null and @props.data.issue_date != undefined 
                                                    @props.data.issue_date
                                                else
                                                    ""
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-envelope icon-fw'
                                        React.DOM.input id:'issue_place', placeholder: 'Địa chỉ email liên lạc', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.issue_place != null and @props.data.issue_place != undefined 
                                                    @props.data.issue_place
                                                else
                                                    ""
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-info icon-fw'
                                        React.DOM.input id:'work_place', placeholder: 'Địa chỉ nơi làm việc', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.work_place != null and @props.data.work_place != undefined 
                                                    @props.data.work_place
                                                else
                                                    ""
                                            else
                                                ""
                        React.DOM.div className: 'col-md-3 pull-right',
                            React.DOM.button className: 'btn btn-lg btn-block btn-static-primary', type: 'submit', "Xác nhận"
                            React.DOM.div className: 'spacer20'
            React.DOM.div className: 'row',
                React.DOM.div className: 'spacer40'
    step2Render: ->
        React.DOM.div className: 'container animated fadeIn',
            React.DOM.section id: 'new-user', className: 'm900 m-l-r-auto',
                React.DOM.div className: 'row fill-white',
                    React.DOM.form id: 'step-2-form', onSubmit: @handleSubmit, autoComplete: 'off',
                        React.DOM.div className: 'col-md-6 col-md-offset-1',
                            React.DOM.div className: 'panel-body',
                                React.DOM.div className: 'panel-heading text-center',
                                    React.DOM.h2 null, "Tiền sử y tế"
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-user icon-fw',
                                        React.DOM.input id:'self_history', placeholder: 'Tiền sử bệnh bản thân', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.self_history != undefined
                                                    ""
                                                else
                                                    @props.data.self_history
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-users icon-fw'
                                        React.DOM.input id:'family_history', placeholder: 'Bệnh di truyền', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.family_history != null and @props.data.family_history != undefined 
                                                    @props.data.family_history
                                                else
                                                    ""
                                            else
                                                ""
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-medkit icon-fw'
                                        React.DOM.input id:'drug_history', placeholder: 'Tiền sử dị ứng thuốc', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.drug_history != null and @props.data.drug_history != undefined 
                                                    @props.data.drug_history
                                                else
                                                    ""
                                            else
                                                ""
                            React.DOM.button className: 'btn btn-lg btn-block btn-static-primary', type: 'submit', "Xác nhận"
                            React.DOM.div className: 'spacer20'
                        React.DOM.div className: 'col-md-5 hidden-xs',
                            React.DOM.div className: 'spacer40'
                            React.DOM.h4 className: 'text-center', 'Tại sao tiền sử y tế là cần thiết ?'
                            React.DOM.ul className: 'text-center list-unstyled small',
                                React.DOM.li null, 'Tiền sử y tế có thể làm thay đổi phương pháp điều trị cho từng căn bệnh mà bệnh nhân gặp phải'
                                React.DOM.li null,
                                    'Việc hiểu rõ tiền sử y tế của bệnh nhân sẽ giúp bác sỹ đưa ra phương án điều trị '
                                    React.DOM.strong null, 'chính xác '
                                    'và '
                                    React.DOM.strong null, 'an toàn nhất '
                                    'cho bệnh nhân.'
            React.DOM.div className: 'row',
                React.DOM.div className: 'spacer40'
    step3Render: ->
        React.DOM.div className: 'container animated fadeIn',
            React.DOM.section id: 'new-user', className: 'm900 m-l-r-auto',
                React.DOM.div className: 'row fill-white',
                    React.DOM.form id: 'step-2-form', onSubmit: @handleSubmit, autoComplete: 'off',
                        React.DOM.div className: 'col-md-6 col-md-offset-1',
                            React.DOM.div className: 'panel-body',
                                React.DOM.div className: 'panel-heading text-center',
                                    React.DOM.h2 null, "Tiền sử y tế"
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-user icon-fw',
                                        React.DOM.input id:'self_history', placeholder: 'Tiền sử bệnh bản thân', type: 'text', className: 'form-control', defaultValue:
                                            if @props.data != null
                                                if @props.data.self_history != undefined
                                                    ""
                                                else
                                                    @props.data.self_history
                                            else
                                                ""
                            React.DOM.button className: 'btn btn-lg btn-block btn-static-primary', type: 'submit', "Xác nhận"
                            React.DOM.div className: 'spacer20'
                        React.DOM.div className: 'col-md-5 hidden-xs',
                            React.DOM.div className: 'spacer40'
                            React.DOM.div className: 'service-info-block',
                                React.DOM.h4 className: 'text-center', 'Dental'
                                React.DOM.p null, "We are a team of young professionals passionate in our work. We work in a friendly and efficient using the latest technologies and sharing our expertise to make a diagnosis and implement cutting-edge therapies."
                                React.DOM.br null
                                React.DOM.ul className: 'fact row',
                                    React.DOM.li null,
                                        React.DOM.p null, 'Qualified Staff of Doctors'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                                React.DOM.span className: 'service-info-block-price', '120.000'
            React.DOM.div className: 'row',
                React.DOM.div className: 'spacer40'
    step4Render: ->
        React.DOM.div className: 'container animated fadeIn',
            React.DOM.section id: 'new-user', className: 'm900 m-l-r-auto',
                React.DOM.div className: 'row fill-white',
                    React.DOM.div className: 'col-md-7 col-md-offset-1 hidden-xs',
                        React.DOM.div className: 'spacer20'
                        React.DOM.table className: 'cart-products',
                            React.DOM.thead null,
                                React.DOM.tr null,
                                    React.DOM.th null, 'Dịch vụ'
                                    React.DOM.th null, 'Đơn giá'
                                    React.DOM.th null, 'Tổng thu'
                            React.DOM.tbody null,
                                React.DOM.tr className: 'product-cart-list',
                                    React.DOM.td null, 'Dental'
                                    React.DOM.td null, '120.000'
                                    React.DOM.td null, '120.000'
                        React.DOM.div className: 'spacer30'
                        React.DOM.div className: 'service-info-block',
                            React.DOM.h4 className: 'text-center', 'Dental'
                                React.DOM.p null, "We are a team of young professionals passionate in our work. We work in a friendly and efficient using the latest technologies and sharing our expertise to make a diagnosis and implement cutting-edge therapies."
                                React.DOM.br null
                                React.DOM.ul className: 'fact row',
                                    React.DOM.li null,
                                        React.DOM.p null, 'Qualified Staff of Doctors'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                                    React.DOM.li null,
                                        React.DOM.p null, 'Feel like you are at Home Services'
                    React.DOM.div className: 'col-md-4',
                        React.DOM.div className: 'spacer40'
                        React.DOM.div className: 'check-out-block',
                            React.DOM.div className: 'check-out-header',
                                React.DOM.span null, 'Tổng thu'
                                React.DOM.span className: 'pull-right', '120.000'
                            React.DOM.div className: 'check-out-normal',
                                React.DOM.span null, 'Thuế và phí'
                                React.DOM.span className: 'pull-right', '0'
                            React.DOM.div className: 'check-out-normal',
                                React.DOM.span null, 'Mã bệnh án'
                                React.DOM.span className: 'pull-right', 'ABCD12'
                        React.DOM.div className: 'check-out-block',
                            React.DOM.div null,
                                React.DOM.span null, 'Tổng'
                                React.DOM.span className: 'check-out-price pull-right', '120.000'
                        React.DOM.div className: 'check-out-block',    
                            React.DOM.button className: 'btn btn-lg btn-block btn-static-primary', type: 'button', "Xác nhận"
                        React.DOM.div null,
                            React.DOM.div null,
                                React.DOM.h3 null, 'Bạn có thắc mắc?'
                                React.DOM.p null, 'Hãy gọi cho chúng tôi theo số 01663212558'
                        React.DOM.div className: 'spacer30'
            React.DOM.div className: 'row',
                React.DOM.div className: 'spacer40'
    render: ->
        switch @props.phase
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