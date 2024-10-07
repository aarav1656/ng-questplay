use src::sorcerer::Sorcerer;
use src::sorcerer_duel::duel;
use src::sorcerer::SorcererTrait;

fn battle(
    ref team1: Array<Sorcerer>, 
    ref team2: Array<Sorcerer>
) {
    // IMPLEMENT THIS FUNCTION

    let mut sorcerer1 = team1.pop_front().unwrap();
    let mut sorcerer2 = team2.pop_front().unwrap();
    let mut counter : u32 = 0;
    

    loop {
        duel(ref sorcerer1, ref sorcerer2);

        if sorcerer1.health == 0 && sorcerer2.health == 0 {
            if team1.len() == 0 && team2.len() == 0 {
                break ();
            }
        }

        if  sorcerer1.health == 0 {
            if team1.len() != 0{
                sorcerer1 = team1.pop_front().unwrap();
            }else{
                copyOrd(ref team2, ref sorcerer2);
                break;
            }
        }
        if  sorcerer2.health == 0 {
            if team2.len() != 0{
                sorcerer2 = team2.pop_front().unwrap();
            }
            else{
                copyOrd(ref team1, ref sorcerer1);
                break;
            }
        }
        counter += 1;
    };

}

fn copyOrd( ref arr: Array<Sorcerer> , ref sor: Sorcerer)  {
    let mut tempArr = ArrayTrait::<Sorcerer>::new();
    let mut size = arr.len()  ;
    let mut counter : u32 = 0;
    tempArr.append(sor);

    if size == 0 {
        arr.append(sor);
    } else{

        loop {
            let s2 = *arr.at(counter);
            tempArr.append(s2);
            counter += 1;
            
            if counter >= size {
                break ();
            }
        };
        
        arr = tempArr;
    }
}