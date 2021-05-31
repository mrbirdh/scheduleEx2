package com.example.scheduleex2.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.format.DateTimeFormatter;
import java.util.Date;

@Getter @Setter @ToString
public class ScheduleVO {
    private int e_id;
    private String e_name;
    private Date e_start;
    private Date e_end;
    private boolean e_allday;
}
