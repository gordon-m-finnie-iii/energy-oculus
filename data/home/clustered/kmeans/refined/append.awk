BEGIN{
# file seperators
FS = ","
OFS = ","
PHASE = 0;
dow = 0;
}

###########################MODIFY INPUT####################################################

{
    if( NR <2 ){
	updateHeader();

    }else{
	#add phase of day attribute {morning,afternoon,evening,night}
	appenPhase();
	#add day of week attribute{Mon, .. ,Sun}
	appenDow();
    }

    print dow" , "PHASE" , "$0;
    
}


#############################FUNCTIONS#####################################################





# # # Day of the week calculation based on the data of a sunday in that month
function appenDow(){
   # shorter than Zeller's 0==SUN 6==SAT
    day = substr($4,11,2) + 0;
    month = substr($4,8,2);
   
    if( month == "05" ){
	dow = day - 25;
    }
    if( month == "06" ){
	dow = (day-1)%7;    
    }
    if( month == "07" ){
	dow = (day+1)%7;
    }

}



# # # phase of day attribute 0=night:1=morning:2=afternoon:3=evening
function appenPhase(){

    time = $3;
    if( time < 70000 ){
	PHASE = 0;
    }else if( time < 110000){
	PHASE = 1;
    }else if( time < 140000 ){
	PHASE = 2;
    }else if( time < 210000 ){
	PHASE = 3;
    }else{
	PHASE = 0;
    }

}

function updateHeader(){

    $0 = "dow , phase , " $0 ;

}