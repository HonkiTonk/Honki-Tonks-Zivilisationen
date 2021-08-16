pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank;

with StadtSuchen, GesamtwerteFeld;

package body KampfwerteEinheitErmitteln is

   -- Mit_Hügel noch berücksichtigen
   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      VerteidigungWert := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Verteidigung;
      
      case
        AngreiferExtern
      is
         when False =>
            VerteidigungWert := VerteidigungWert + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                                     RasseExtern       => EinheitRasseNummerExtern.Rasse);
            
            case
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung
            is
               when GlobaleDatentypen.Verschanzen =>
                  if
                    Float (VerteidigungWert) * VerschanzungBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
                     
                  else              
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld (Float (VerteidigungWert) * VerschanzungBonus);
                  end if;
                  
               when others =>
                  null;
            end case;
            
            case
              StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                          KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position)
            is
               when GlobaleKonstanten.LeerEinheitStadtNummer =>
                  null;
                  
               when others =>
                  if
                    Float (VerteidigungWert) * StadtBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
                     
                  else              
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld (Float (VerteidigungWert) * StadtBonus);
                  end if;
            end case;
              
         when True =>
            null;
      end case;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungEinheit;
   
   
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      AngriffWert := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Angriff;
      
      case
        AngreiferExtern
      is
         when True =>
            AngriffWert := AngriffWert + GesamtwerteFeld.FeldAngriff (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                      RasseExtern       => EinheitRasseNummerExtern.Rasse);
            
            -- Diesen Bonus anders gestalten, vielleicht auf Basis der Bewegungspunkte?
            if
              Float (AngriffWert) * AngriffBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
            then
               AngriffWert := GlobaleDatentypen.ProduktionFeld'Last;
                 
            else              
               AngriffWert := GlobaleDatentypen.ProduktionFeld (Float (AngriffWert) * AngriffBonus);
            end if;
            
         when False =>
            null;
      end case;
     
      return AngriffWert;
   
   end AktuellerAngriffEinheit;

end KampfwerteEinheitErmitteln;
