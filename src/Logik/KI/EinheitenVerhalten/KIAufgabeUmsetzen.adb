pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;

with Aufgaben;

package body KIAufgabeUmsetzen is
   
   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            if
              VerbesserungGebiet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return True;
               
            else
               null;
            end if;
      
         when others =>
            null;
      end case;
      
      case
        LeseKarten.VerbesserungWeg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
            return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BefehlExtern             => TastenbelegungDatentypen.Straße_Bauen_Enum);
            
         when others =>
            null;
      end case;
      
      return False;
      
   end WelcheVerbesserungAnlegen;
   
   
   
   function VerbesserungGebiet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      Grund := LeseKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
         
      if
        (Grund = KartenGrundDatentypen.Hügel_Enum
         or
           Grund = KartenGrundDatentypen.Gebirge_Enum
         or
           Grund = KartenGrundDatentypen.Kohle_Enum
         or
           Grund = KartenGrundDatentypen.Eisen_Enum
         or
           Grund = KartenGrundDatentypen.Gold_Enum
         or
           LeseKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True)
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => TastenbelegungDatentypen.Mine_Bauen_Enum)
        = True
      then
         Befehl := TastenbelegungDatentypen.Mine_Bauen_Enum;
         
      elsif
        Grund = KartenGrundDatentypen.Eis_Enum
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => TastenbelegungDatentypen.Festung_Bauen_Enum)
        = True
      then
         Befehl := TastenbelegungDatentypen.Festung_Bauen_Enum;
         
      elsif
        Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => TastenbelegungDatentypen.Farm_Bauen_Enum)
        = True
      then
         Befehl := TastenbelegungDatentypen.Farm_Bauen_Enum;
            
      else
         return False;
      end if;
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => Befehl);
      
   end VerbesserungGebiet;
      
      

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      NullWert := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => TastenbelegungDatentypen.Einheit_Verbessern_Enum);
      
      return False;
      
   end EinheitVerbessern;

end KIAufgabeUmsetzen;
