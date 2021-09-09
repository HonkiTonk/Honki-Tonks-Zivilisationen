pragma SPARK_Mode (On);

with LeseKarten, LeseEinheitenGebaut;

with Verbesserungen;

package body KIAufgabeUmsetzen is
   
   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        LeseKarten.VerbesserungGebiet (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
      when GlobaleDatentypen.Leer =>         
         Grund := LeseKarten.Grund (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
         if
           (Grund = GlobaleDatentypen.Hügel 
            or
              Grund = GlobaleDatentypen.Gebirge
            or
              Grund = GlobaleDatentypen.Kohle
            or
              Grund = GlobaleDatentypen.Eisen
            or
              Grund = GlobaleDatentypen.Gold
            or
              LeseKarten.Hügel (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True)
           and
             Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => GlobaleDatentypen.Mine_Bauen)
           = True
         then
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Mine_Bauen);
            return True;
         
         elsif
           Grund = GlobaleDatentypen.Eis
           and
             Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => GlobaleDatentypen.Festung_Bauen)
           = True
         then
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Festung_Bauen);
            return True;
         
         elsif
           Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BefehlExtern             => GlobaleDatentypen.Farm_Bauen)
           = True
         then
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Farm_Bauen);
            return True;
            
         else
            null;
         end if;
      
      when others =>
         null;
      end case;
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when GlobaleDatentypen.Leer =>
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Straße_Bauen);
            return True;
            
         when others =>
            null;
      end case;
      
      return False;
      
   end WelcheVerbesserungAnlegen;
      
      

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      NullWert := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      BefehlExtern             => GlobaleDatentypen.Einheit_Verbessern);
      
      return False;
      
   end EinheitVerbessern;

end KIAufgabeUmsetzen;
