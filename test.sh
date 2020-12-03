source ./func1.sh
source ./func2.sh


count=254

while ( true )

do
        hour=$(date '+%H')
        min=$(date '+%M')
        sec=$(date '+%S')

        if [ $sec -gt 58 ]
                then
                        echo $hour $min $sec
                        func1
                        func2
                        if [ $count = 255 ]
                                then
                                        count=1
                                else
                                (( count++ ))
                        fi
        fi
        #echo $min
        sleep .5
done
