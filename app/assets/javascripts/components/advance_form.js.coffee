@SubmitInfoForm = React.createClass
    getInitialState: ->
        steps: 1
        serviceList: @props.services
        userInfo: null
        medicalInfo: null
        serviceInfo: null
        stepMenu: [
            {code: 1, img: @props.phase1, bigtext: 'Bước 1', smalltext: 'Tạo thông tin cá nhân'}
            {code: 2, img: @props.phase2, bigtext: 'Bước 2', smalltext: 'Tiền sử y tế'}
            {code: 3, img: @props.phase3, bigtext: 'Bước 3', smalltext: 'Đăng ký dịch vụ'}
            {code: 4, img: @props.phase4, bigtext: 'Bước 4', smalltext: 'Xác nhận đăng ký'}
        ]
        formData: null
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
    triggerphase1: (user_info, formData)->
        @setState
            userInfo: user_info
            formData: formData
            steps: 2
    triggerphase2: (medicalinfo)->
        @setState
            medicalInfo: medicalinfo
            steps: 3
    triggerphase3: (serviceinfo)->
        if serviceinfo.service_id == "0"
            @showtoast("Bạn cần chọn dịch vụ trước khi ấn xác nhận",3)
        else
            @setState
                serviceInfo: serviceinfo
                steps: 4
    triggerphase4: (token)->
        @showtoast("Vui lòng chờ trong giây lát",2)
        formData = @state.formData
        formData.append 'cname', @state.userInfo.cname
        formData.append 'dob', @state.userInfo.dob
        formData.append 'gender', @state.userInfo.gender
        formData.append 'address', @state.userInfo.address
        formData.append 'pnumber', @state.userInfo.pnumber
        formData.append 'noid', @state.userInfo.noid
        formData.append 'issue_date', @state.userInfo.issue_date
        formData.append 'issue_place', @state.userInfo.issue_place
        formData.append 'work_place', @state.userInfo.work_place
        formData.append 'self_history', @state.medicalInfo.self_history
        formData.append 'family_history', @state.medicalInfo.family_history
        formData.append 'drug_history', @state.medicalInfo.drug_history
        formData.append 'service_id', @state.serviceInfo.service_id
        formData.append 'token', token.token
        $.ajax
            url: '/request'
            type: 'POST'
            data: formData
            async: false
            cache: false
            contentType: false
            processData: false
            error: ((result) ->
                @showtoast("Đăng ký thất bại, vui lòng thử lại",3)
                return
            ).bind(this)
            success: ((result) ->
                if result != null
                    @showtoast('Chúc mừng bạn đăng ký khám bệnh thành công. Phiếu khám bệnh của bạn có số: ' + result.id + '. Mọi thông tin về phiếu khám của bạn đã được gửi về địa chỉ email mà bạn đã đăng ký khám',1)
                    setTimeout (->
                        window.location.replace("/")
                    ), 5000
                else
                    @showtoast("Đăng ký thất bại, vui lòng thử lại",3)
                return
            ).bind(this)
    phase1Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: @state.userInfo, phase: @state.steps, trigger: @triggerphase1
    phase2Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: @state.medicalInfo, phase: @state.steps, trigger: @triggerphase2
    phase3Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: @state.serviceInfo, service: @state.serviceList, phase: @state.steps, trigger: @triggerphase3
    phase4Render: ->
        React.DOM.div className: 'blurred-dashboard clear-page',
            React.DOM.div className: 'text-center dark',
                React.DOM.a href: '/',
                    React.DOM.img alt: "Aligosa504x160 dark", height: '82.5', src: @props.logo, width: '260'
                React.DOM.h1 className: 'h3', "Quản lý theo cách của bạn bằng công cụ của chúng tôi"
                React.DOM.div className: 'spacer20',
            React.createElement phaseMenu, phase: @state.steps, data: @state.stepMenu, trigger: @changesteps
            React.DOM.div className: 'spacer20'
            React.createElement phaseForm, data: @state.serviceInfo, service: @state.serviceList, phase: @state.steps, trigger: @triggerphase4
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
        service_info:
            if @props.data != null
                for service in @props.service
                    if Number(@props.data.service_id) ==  service.id
                        service
                        break
            else
                null
        token: @generateToken()
    generateToken: ->
        text = ''
        possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        i = 0
        while i < 6
            text += possible.charAt(Math.floor(Math.random() * possible.length))
            i++
        text
    triggerChangeType: ->
        for service in @props.service
            if Number($("#services_list").val()) ==  service.id
                @setState service_info: service
    handleSubmit: (e) ->
        e.preventDefault()
        switch @props.phase
            when 1
                user_info = {
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
                medical_history = {
                    self_history: $('#step-2-form #self_history').val()
                    family_history: $('#step-2-form #family_history').val()
                    drug_history: $('#step-2-form #drug_history').val()
                }
                @props.trigger medical_history
            when 3
                service_chose = {
                    service_id: $('#services_list').val()
                }
                @props.trigger service_chose
    handleSubmitButton: ->
        switch @props.phase
            when 4
                token = {
                    token: @state.token
                }
                @props.trigger token
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
                                                if @props.data.cname != null and @props.data.cname != undefined 
                                                    @props.data.cname
                                                else
                                                    ""
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
                                            if @props.data.gender == "1"
                                                React.DOM.select className: 'form-control', id: 'gender', defaultValue: '1',
                                                    React.DOM.option value: 1, "Nam"
                                                    React.DOM.option value: 2, "Nữ"
                                            else if @props.data.gender == "2"
                                                React.DOM.select className: 'form-control', id: 'gender', defaultValue: '2',
                                                    React.DOM.option value: 2, "Nữ"
                                                    React.DOM.option value: 1, "Nam"
                                            else
                                                React.DOM.select className: 'form-control', id: 'gender', defaultValue: '0',
                                                    React.DOM.option value: 0, "Giới tính"
                                                    React.DOM.option value: 1, "Nam"
                                                    React.DOM.option value: 2, "Nữ"
                                        else
                                            React.DOM.select className: 'form-control', id: 'gender', defaultValue: '0',
                                                React.DOM.option value: 0, "Giới tính"
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
                                                if @props.data.self_history != null and @props.data.self_history != undefined 
                                                    @props.data.self_history
                                                else
                                                    ""
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
                    React.DOM.form id: 'step-3-form', onSubmit: @handleSubmit, autoComplete: 'off',
                        React.DOM.div className: 'col-md-6 col-md-offset-1',
                            React.DOM.div className: 'panel-body',
                                React.DOM.div className: 'panel-heading text-center',
                                    React.DOM.h2 null, "Tiền sử y tế"
                                React.DOM.div className: 'form-group email optional user_email',
                                    React.DOM.div className: 'input-group',
                                        React.DOM.span className: 'input-group-addon',
                                            React.DOM.i className: 'fa fa-user icon-fw',
                                        React.DOM.select id: 'services_list', className: 'form-control', onChange: @triggerChangeType,
                                            React.DOM.option value: 0, 'Chọn dịch vụ'
                                            for service in @props.service
                                                React.DOM.option value: service.id, key: service.id, service.sname
                            React.DOM.button className: 'btn btn-lg btn-block btn-static-primary', type: 'submit', "Xác nhận"
                            React.DOM.div className: 'spacer20'
                        React.DOM.div className: 'col-md-5 hidden-xs',
                            React.DOM.div className: 'spacer40'
                            if @state.service_info != null
                                React.DOM.div className: 'service-info-block',
                                    React.DOM.h4 className: 'text-center', @state.service_info.sname
                                    React.createElement 'service_info_block_child', dangerouslySetInnerHTML: __html: @state.service_info.description
                                    React.DOM.span className: 'service-info-block-price', @state.service_info.price
                            else
                                React.DOM.div className: 'service-info-block',
                                    React.DOM.h4 className: 'text-center', 'Mời bạn chọn dịch vụ trong danh sách'
                        
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
                                    React.DOM.td null, @state.service_info.sname
                                    React.DOM.td null, @state.service_info.price
                                    React.DOM.td null, @state.service_info.price
                        React.DOM.div className: 'spacer30'
                        React.DOM.div className: 'service-info-block',
                            React.DOM.h4 className: 'text-center', @state.service_info.sname
                                React.createElement 'service_info_block_child', dangerouslySetInnerHTML: __html: @state.service_info.description
                    React.DOM.div className: 'col-md-4',
                        React.DOM.div className: 'spacer40'
                        React.DOM.div className: 'check-out-block',
                            React.DOM.div className: 'check-out-header',
                                React.DOM.span null, 'Tổng thu'
                                React.DOM.span className: 'pull-right', @state.service_info.price
                            React.DOM.div className: 'check-out-normal',
                                React.DOM.span null, 'Thuế và phí'
                                React.DOM.span className: 'pull-right', '0'
                            React.DOM.div className: 'check-out-normal',
                                React.DOM.span null, 'Mã bệnh án'
                                React.DOM.span className: 'pull-right', @state.token
                        React.DOM.div className: 'check-out-block',
                            React.DOM.div null,
                                React.DOM.span null, 'Tổng'
                                React.DOM.span className: 'check-out-price pull-right', @state.service_info.price
                        React.DOM.div className: 'check-out-block',    
                            React.DOM.button className: 'btn btn-lg btn-block btn-static-primary', type: 'button', onClick: @handleSubmitButton, "Xác nhận"
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
        

@servicesMenu = React.createClass
    getInitialState: ->
        service_info: null
    changeService: (service)->
        @setState service_info: service
    normalRender: ->
        React.DOM.div className: 'row',
            React.createElement serviceTab, className: 'col-sm-3', service: @state.service_info, serviceList: @props.services, trigger: @changeService
            React.createElement serviceContent, className: 'col-sm-9', service: @state.service_info
    render: ->
        @normalRender()
        

@serviceTab = React.createClass
    getInitialState: ->
        style: 1
    trigger: (service) ->
        @props.trigger service
    normalRender: ->
        React.DOM.div className: @props.className,
            React.DOM.div className: 'tab-head-block',
                for service in @props.serviceList
                    React.createElement serviceTabChild, service: service, service_info: @props.service, key: service.id, trigger: @trigger
    render: ->
        @normalRender()


@serviceTabChild = React.createClass
    getInitialState: ->
        style: 1
    trigger: ->
        @props.trigger @props.service
    normalRender: ->
        if @props.service_info != null
            if @props.service.id == @props.service_info.id
                React.DOM.div className: 'tab-head active',
                    React.DOM.i className: 'animated bounceInLeft fa fa-long-arrow-right'
                    @props.service.sname
            else
                React.DOM.div className: 'tab-head', onClick: @trigger, @props.service.sname
        else
            React.DOM.div className: 'tab-head', onClick: @trigger, @props.service.sname
    render: ->
        @normalRender()
        

@serviceContent = React.createClass
    getInitialState: ->
        style: 1
    normalRender: ->
        React.DOM.div className: 'col-sm-9',
            React.DOM.div className: 'tab-content-block',
                if @props.service != null
                    React.DOM.div className: ' tab-content animated fadeIn',
                        React.DOM.h4 null, @props.service.sname
                        React.createElement 'service_info_block_child', dangerouslySetInnerHTML: __html: @props.service.description
                        React.DOM.a className: 'btn btn-tab-content pull-left', href: '#', "TÌM HIỂU THÊM"
                        React.DOM.span className: 'pricing', "Từ " + @props.service.price + " VNĐ"
                else
                    React.DOM.div className: ' tab-content animated fadeIn',
                        React.DOM.h4 null, "Mời bạn chọn dịch vụ để xem chi tiết"
    render: ->
        @normalRender()
        
        
@resultMenu = React.createClass
    getInitialState: ->
        result: @props.data
    normalRender: ->
        React.DOM.div className: "container",
            React.DOM.div className: "resultRequestBlock m400 m-l-r-auto",
                React.DOM.h3 className: "text-center", "XEM KẾT QUẢ KHÁM"
                React.DOM.div className: "spacer20"
                React.DOM.form onSubmit: @handleSubmit, autoComplete: 'off',
                    React.DOM.div className: 'form-group email optional user_email',
                        React.DOM.div className: 'input-group',
                            React.DOM.span className: 'input-group-addon',
                                React.DOM.i className: 'fa fa-info icon-fw'
                            React.DOM.input id:'work_place', placeholder: 'Địa chỉ nơi làm việc', type: 'text', className: 'form-control'
                    React.DOM.div className: 'form-group email optional user_email',
                        React.DOM.div className: 'input-group',
                            React.DOM.span className: 'input-group-addon',
                                React.DOM.i className: 'fa fa-info icon-fw'
                            React.DOM.input id:'work_place', placeholder: 'Địa chỉ nơi làm việc', type: 'text', className: 'form-control'
                    React.DOM.button className: 'btn btn-special', type: "submit", "Gửi yêu cầu"
            React.DOM.div className: "spacer60"
            React.DOM.div className: "resultButtonBlock text-center",
                React.DOM.button className: "btn btn-icon-text active",
                    React.DOM.i className: "fa fa-sticky-note"
                    " Thông tin bệnh nhân"
                React.DOM.button className: "btn btn-icon-text",
                    React.DOM.i className: "fa fa-sticky-note-o"
                    " Thông tin điều trị"
                React.DOM.button className: "btn btn-icon-text",
                    React.DOM.i className: "fa fa-stethoscope"
                    " Khám lâm sàng"
                React.DOM.button className: "btn btn-icon-text",
                    React.DOM.i className: "fa fa-medkit"
                    " Đơn thuốc"
                React.DOM.button className: "btn btn-icon-text",
                    React.DOM.i className: "fa fa-hospital-o"
                    " Thuốc do phòng khám cung cấp"
            React.DOM.div className: "spacer60"
            React.DOM.div className: "resultPanelBlock m900 m-l-r-auto",
                React.DOM.h3 className: "text-center", "Thông tin bệnh nhân"
                React.DOM.div className: "spacer40"
                React.DOM.div className: "row",
                    React.DOM.div className: "col-sm-8",
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Họ và tên:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "Hoàng Minh Hùng"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Ngày sinh:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "23/01/1992"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Tuổi:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "25 (5 tháng 3 ngày)"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Giới tính:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "Nam"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Địa chỉ:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "267A Vĩnh Hưng, Hoàng Mai, Hà Nội"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Số ĐT:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "01663212558"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Số CMTND:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "012902810"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Nơi công tác:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "Số 1 Lương Yên, Hai Bà Trưng, Hà Nội"
                        React.DOM.p null, "Tiền sử bệnh :"
                        React.DOM.p className: "textinfo", "Bệnh tim"
                        React.DOM.p null, "Bệnh di truyền:"
                        React.DOM.p className: "textinfo", "Không có"
                        React.DOM.p null, "Dị ứng thuốc :"
                        React.DOM.p className: "textinfo", "Không có"
                    React.DOM.div className: "col-sm-4",
                        React.DOM.img src: "/assets/doctor1.jpg"
            React.DOM.div className: "spacer60"
            React.DOM.div className: "resultPanelBlock m900 m-l-r-auto",
                React.DOM.h3 className: "text-center", "Thông tin điều trị"
                React.DOM.div className: "spacer40"
                React.DOM.div className: "row",
                    React.DOM.div className: "col-sm-12",
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Bác sỹ:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "Trần Minh Hoàng"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Bệnh nhân:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "Hoàng Minh Hùng"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Ngày bắt đầu:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "2016-10-03"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Ngày kết thúc:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "2016-10-03"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-3 hidden-xs",
                                React.DOM.p null, "Tình trạng:"
                            React.DOM.div className: "col-sm-9",
                                React.DOM.p className: "info", "Kết thúc"
                        React.DOM.p null, "Kết luận :"
                        React.DOM.p className: "textinfo", "Bệnh tim"
                        React.DOM.p null, "Chuẩn đoán:"
                        React.DOM.p className: "textinfo", "Không có"
                        React.DOM.p null, "Hướng điều trị :"
                        React.DOM.p className: "textinfo", "Không có"
            React.DOM.div className: "spacer60"
            React.DOM.div className: "resultPanelBlock m900 m-l-r-auto",
                React.DOM.h3 className: "text-center", "Khám lâm sàng"
                React.DOM.div className: "spacer40"
                React.DOM.div className: "row",
                    React.DOM.div className: "col-sm-8",
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-4 hidden-xs",
                                React.DOM.p null, "Bác sỹ:"
                            React.DOM.div className: "col-sm-8",
                                React.DOM.p className: "info", "Trần Minh Hoàng"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-4 hidden-xs",
                                React.DOM.p null, "Bệnh nhân:"
                            React.DOM.div className: "col-sm-8",
                                React.DOM.p className: "info", "Hoàng Minh Hùng"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-4 hidden-xs",
                                React.DOM.p null, "Quá trình bệnh lý:"
                            React.DOM.div className: "col-sm-8",
                                React.DOM.p className: "info", "Không có vấn đề gì"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-4 hidden-xs",
                                React.DOM.p null, "Khám lâm sàng:"
                            React.DOM.div className: "col-sm-8",
                                React.DOM.p className: "info", "Chỉ là các triệu chứng bình thường của bệnh cảm"
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-4 hidden-xs",
                                React.DOM.p null, "Tình trạng:"
                            React.DOM.div className: "col-sm-8",
                                React.DOM.p className: "info", "Kết thúc"
                        React.DOM.p null, "Kết luận :"
                        React.DOM.p className: "textinfo", "Bệnh tim"
                        React.DOM.p null, "Chuẩn đoán:"
                        React.DOM.p className: "textinfo", "Không có"
                        React.DOM.p null, "Hướng điều trị :"
                        React.DOM.p className: "textinfo", "Không có"
                React.DOM.div className: "row",
                    React.DOM.div className: "col-sm-4",
                        React.DOM.div className: "row",
                            React.DOM.div className: "col-sm-8",
                                React.DOM.p null, "Bác sỹ:"
                            React.DOM.div className: "col-sm-4",
                                React.DOM.p className: "info", "Trần Minh Hoàng"
    render: ->
        @normalRender()
