with LeseWeltkarte;

package body KartenfeldereffekteLogik is

   function FeldeffektVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      FeldeffekteSchleife:
      for FeldeffektSchleifenwert in KartenRecords.FeldeffektArray'Range loop
                  
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                 WelcherEffektExtern => FeldeffektSchleifenwert)
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
                  
      end loop FeldeffekteSchleife;
      
      return False;
      
   end FeldeffektVorhanden;

end KartenfeldereffekteLogik;
