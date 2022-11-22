with WichtigesKonstanten;
with TextnummernKonstanten;

with SchreibeDiplomatie;
with LeseDiplomatie;

with JaNeinLogik;

package body DiplomatischerZustandLogik is

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
   is
      use type DiplomatieDatentypen.Meinung;
   begin
      
      SchreibeDiplomatie.AktuellerZustand (RasseEinsExtern => RasseEinsExtern,
                                           RasseZweiExtern => RasseZweiExtern,
                                           ZustandExtern   => NeuerStatusExtern);
      
      SchreibeDiplomatie.AktuellerZustand (RasseEinsExtern => RasseZweiExtern,
                                           RasseZweiExtern => RasseEinsExtern,
                                           ZustandExtern   => NeuerStatusExtern);
      
      SchreibeDiplomatie.ZeitSeitÄnderung (RasseEinsExtern     => RasseEinsExtern,
                                           RasseZweiExtern     => RasseZweiExtern,
                                           ÄnderungExtern      => 0,
                                            RechnenSetzenExtern => False);
      
      SchreibeDiplomatie.ZeitSeitÄnderung (RasseEinsExtern     => RasseZweiExtern,
                                            RasseZweiExtern     => RasseEinsExtern,
                                            ÄnderungExtern      => 0,
                                            RechnenSetzenExtern => False);
            
      case
        NeuerStatusExtern
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            SchreibeDiplomatie.AktuelleSympathie (RasseEinsExtern     => RasseEinsExtern,
                                                  RasseZweiExtern     => RasseZweiExtern,
                                                  SympathieExtern     => -30,
                                                  RechnenSetzenExtern => False);
            
            SchreibeDiplomatie.AktuelleSympathie (RasseEinsExtern     => RasseZweiExtern,
                                                  RasseZweiExtern     => RasseEinsExtern,
                                                  SympathieExtern     => -30,
                                                  RechnenSetzenExtern => False);
            
         when others =>
            null;
      end case;
      
   end DiplomatischenStatusÄndern;



   function GegnerAngreifen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (RasseEinsExtern => EigeneRasseExtern,
                                         RasseZweiExtern => GegnerischeRasseExtern)
      is
         when DiplomatieDatentypen.Neutral_Enum =>
            if
              WichtigesKonstanten.DiplomatischerStatusÄnderungszeit >= LeseDiplomatie.ZeitSeitÄnderung (RasseEinsExtern => EigeneRasseExtern,
                                                                                                          RasseZweiExtern => GegnerischeRasseExtern)
            then
               return False;
              
            elsif
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageKriegErklären) = True
            then
               DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                            RasseZweiExtern   => GegnerischeRasseExtern,
                                            NeuerStatusExtern => DiplomatieDatentypen.Krieg_Enum);
               return True;
                  
            else
               return False;
            end if;
                  
         when DiplomatieDatentypen.Krieg_Enum =>
            return True;

         when others =>
            return False;
      end case;
      
   end GegnerAngreifen;

end DiplomatischerZustandLogik;
