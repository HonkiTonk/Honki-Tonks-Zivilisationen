pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with StadtSuchen;
with GesamtwerteFeld;

package body KampfwerteEinheitErmitteln is

   -- Mit_Hügel noch berücksichtigen
   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      VerteidigungWert := LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                               IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        AngreiferExtern
      is
         when False =>
            Bonus := VerteidigungsbonusVerteidiger (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            Bonus := VerteidigungsbonusAngreifer;
      end case;
      
      if
        VerteidigungWert + Bonus > EinheitStadtDatentypen.Kampfwerte'Last
      then
         return EinheitStadtDatentypen.Kampfwerte'Last;
         
      else
         return VerteidigungWert + Bonus;
      end if;
      
   end AktuelleVerteidigungEinheit;
   
   
   
   function VerteidigungsbonusVerteidiger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      VerteidigungWertFloat := Float (GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        RasseExtern       => EinheitRasseNummerExtern.Rasse));
      
      case
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when SystemKonstanten.VerschanzenKonstante =>
            VerteidigungWertFloat := VerteidigungWertFloat * VerschanzungBonus;
                  
         when others =>
            null;
      end case;
            
      case
        StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                    KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when StadtKonstanten.LeerNummer =>
            null;
                  
         when others =>
            VerteidigungWertFloat := VerteidigungWertFloat * StadtBonus;
      end case;
              
      if
        VerteidigungWertFloat > Float (EinheitStadtDatentypen.GesamtproduktionStadt'Last)
      then
         return EinheitStadtDatentypen.Kampfwerte'Last;
               
      else
         return EinheitStadtDatentypen.Kampfwerte (VerteidigungWertFloat);
      end if;
      
   end VerteidigungsbonusVerteidiger;
   
   
   
   function VerteidigungsbonusAngreifer
     return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return 0;
      
   end VerteidigungsbonusAngreifer;
   
   
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      AngriffWert := LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                     IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        AngreiferExtern
      is
         when True =>
            Bonus := AngriffsbonusAngreifer (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            Bonus := AngriffsbonusVerteidiger;
      end case;
     
      if
        AngriffWert + Bonus > EinheitStadtDatentypen.Kampfwerte'Last
      then
         return EinheitStadtDatentypen.Kampfwerte'Last;
         
      else
         return AngriffWert + Bonus;
      end if;
   
   end AktuellerAngriffEinheit;
   
   
   
   function AngriffsbonusAngreifer
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      AngriffWertFloat := Float (GesamtwerteFeld.FeldAngriff (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                              RasseExtern       => EinheitRasseNummerExtern.Rasse));
            
      -- Diesen Bonus anders gestalten, vielleicht auf Basis der Bewegungspunkte?
      AngriffWertFloat := AngriffWertFloat * AngriffBonus;
            
      if
        AngriffWertFloat > Float (EinheitStadtDatentypen.ProduktionFeld'Last)
      then
         return EinheitStadtDatentypen.Kampfwerte'Last;
               
      else
         return EinheitStadtDatentypen.Kampfwerte (AngriffWertFloat);
      end if;
      
   end AngriffsbonusAngreifer;
   
   
   
   function AngriffsbonusVerteidiger
     return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      return 0;
      
   end AngriffsbonusVerteidiger;

end KampfwerteEinheitErmitteln;
