            $(document).ready(function () {
                $(".numeric").numeric({ negative: false , decimal: false});
                $(".numeric").keyup(
                function () {
                    $("#pay_amount").attr('value', $(".numeric").val());                    
                });
                $('.numeric').focus();
            }); 