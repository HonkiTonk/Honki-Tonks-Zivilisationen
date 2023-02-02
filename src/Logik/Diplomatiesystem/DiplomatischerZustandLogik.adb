with WichtigesKonstanten;
with TextnummernKonstanten;

with SchreibeDiplomatie;
with LeseDiplomatie;

with JaNeinLogik;

package body DiplomatischerZustandLogik is

   procedure DiplomatischenStatusÄndern
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
   is
      use type DiplomatieDatentypen.Meinung;
   begin
      
      SchreibeDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesEinsExtern,
                                           SpeziesZweiExtern => SpeziesZweiExtern,
                                           ZustandExtern     => NeuerStatusExtern);
      
      SchreibeDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesZweiExtern,
                                           SpeziesZweiExtern => SpeziesEinsExtern,
                                           ZustandExtern     => NeuerStatusExtern);
      
      SchreibeDiplomatie.ZeitSeitÄnderung (SpeziesEinsExtern   => SpeziesEinsExtern,
                                            SpeziesZweiExtern   => SpeziesZweiExtern,
                                            ÄnderungExtern      => 0,
                                            RechnenSetzenExtern => False);
      
      SchreibeDiplomatie.ZeitSeitÄnderung (SpeziesEinsExtern   => SpeziesZweiExtern,
                                            SpeziesZweiExtern   => SpeziesEinsExtern,
                                            ÄnderungExtern      => 0,
                                            RechnenSetzenExtern => False);
            
      case
        NeuerStatusExtern
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => SpeziesEinsExtern,
                                                  SpeziesZweiExtern   => SpeziesZweiExtern,
                                                  SympathieExtern     => -30,
                                                  RechnenSetzenExtern => False);
            
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => SpeziesZweiExtern,
                                                  SpeziesZweiExtern   => SpeziesEinsExtern,
                                                  SympathieExtern     => -30,
                                                  RechnenSetzenExtern => False);
            
         when others =>
            null;
      end case;
      
   end DiplomatischenStatusÄndern;



   function GegnerAngreifen
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GegnerischeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => EigeneSpeziesExtern,
                                         SpeziesZweiExtern => GegnerischeSpeziesExtern)
      is
         when DiplomatieDatentypen.Neutral_Enum =>
            if
              WichtigesKonstanten.DiplomatischerStatusÄnderungszeit >= LeseDiplomatie.ZeitSeitÄnderung (SpeziesEinsExtern => EigeneSpeziesExtern,
                                                                                                          SpeziesZweiExtern => GegnerischeSpeziesExtern)
            then
               return False;
              
            elsif
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageKriegErklären) = True
            then
               DiplomatischenStatusÄndern (SpeziesEinsExtern => EigeneSpeziesExtern,
                                            SpeziesZweiExtern => GegnerischeSpeziesExtern,
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
