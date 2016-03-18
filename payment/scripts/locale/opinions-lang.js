(function ($) {
    'use strict';

    $.opinions.locales['zh'] = {
        examine:[
            {title:"同意"},
            {title:"拟同意"},
            {title:"不同意"}
        ],
        edit:[
            {title:"支付单已更新"},
            {title:"附件已更新"},
            {title:"支付单修改完成，请领导审批"}
        ],
        recheck:[
            {title:"已复核，请领导过目"}
        ],
        apply:[
            {title:"请领导审批支付单"}
        ]

    };

    $.opinions.locales['en'] = {
        examine:[
            {title:"agree"},
            {title:"almost agree"},
            {title:"not agree"}
        ],
        edit:[
            {title:"payment has been updated"},
            {title:"attechment has been updated"},
            {title:"payment has been updated，please examine!"}
        ],
        recheck:[
            {title:"already rechecked，please review!"}
        ],
        apply:[
            {title:"please examine!"}
        ]
    };

})(jQuery);