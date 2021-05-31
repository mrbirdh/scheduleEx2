<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8' />
    <link href='static/css/main.min.css' rel='stylesheet' />
    <style>
        .fc-event {
            margin-top: 5px;
            cursor:move
        }
    </style>
    <script src='static/js/main.min.js'></script>
    <script src='static/js/ko.js'></script>
    <script>
        var calendar = null;
        document.addEventListener('DOMContentLoaded', function() {
            var Calendar = FullCalendar.Calendar;
            var Draggable = FullCalendar.Draggable;

            var containerEl = document.getElementById('external-events');
            var calendarEl = document.getElementById('calendar');
            var checkbox = document.getElementById('drop-remove');

            // initialize the external events
            // -----------------------------------------------------------------
            // 드래그기능
            new Draggable(containerEl, {
                itemSelector: '.fc-event', //어떤걸 드래그할 지
                eventData: function(eventEl) {
                    return {
                        title: eventEl.innerText
                    };
                } ,
                locale : 'ko'
            });

            // initialize the calendar
            // -----------------------------------------------------------------

            calendar = new Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                editable: true,
                droppable: true, // this allows things to be dropped onto the calendar
                drop: function(info) {
                    // is the "remove after drop" checkbox checked?
                    if (checkbox.checked) {
                        // if so, remove the element from the "Draggable Events" list
                        info.draggedEl.parentNode.removeChild(info.draggedEl);
                    }
                }
            });

            calendar.render();
        });

        function all_save() {
            var all_event = calendar.getEvents();

            var events = new Array();
            for (var i = 0; i < all_event.length; i++) {
                var obj = new Object();

                obj.title = all_event[i]._def.title; //이벤트명
                obj.allday = all_event[i]._def.allDay; // 하루종일 이벤트가 진행되는 지 true,false
                obj.start = all_event[i]._instance.range.start; // 이벤트가 언제부터 시작하는 지
                obj.end = all_event[i]._instance.range.end; //이벤트가 언제 끝나는 지

                events.push(obj); //json형태로 담음
            }
            var json =  JSON.stringify(events); //String 형태로 보낼 것이라서
            console.log(json);
            saved_data(json)
        }

        function saved_data (json) {
            $.ajax({
                type: 'POST',
                url : 'savedata.jsp', //여기서 데이터 값을 저장할 예정
                data : { "alldata" : json},
                dataType: 'text' ,
                async:false // 동기식으로 보낼 것
            })
                .done(function (result) {

                })
                .fail(function (request , status, error) {
                    alert("에러 : "  + error);
                });
        }

    </script>
</head>
<body>


<div id='external-events' style="float: left; width: 15%; padding-right: 30px; padding-left:20px; margin-top: 100px">
    <p>
        <strong>Draggable Events</strong>
    </p>

    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
        <div class='fc-event-main'>Hyundai</div>
    </div>
    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
        <div class='fc-event-main'>Kia</div>
    </div>
    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
        <div class='fc-event-main'>Samsung</div>
    </div>
    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
        <div class='fc-event-main'>Chevrolet</div>
    </div>
    <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
        <div class='fc-event-main'>Ssangyong</div>
    </div>

    <p>
        <input type='checkbox' id='drop-remove' />
        <label for='drop-remove'>Release And Remove ! </label>
    </p>
</div>

<div style="float: left; width: 80%">
    <div style="height:30px; text-align: center; font-size: 35px; color: blue; margin-bottom: 30px; font-weight: bold ">
        <div style="width: 60%;float: left; text-align: right">Sales Management Status</div>
        <div style="width: 40%;float: left; text-align: right">
            <button style="width: 120px; height: 40px; background-color: grey; color: white; vertical-align: middle; font-size: 17px; cursor: pointer" onclick="all_save();">
                All Save
            </button>
        </div>
    </div>
    <div id='calendar'></div>
</div>
</body>
</html>