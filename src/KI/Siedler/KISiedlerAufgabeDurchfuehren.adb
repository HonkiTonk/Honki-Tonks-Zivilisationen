pragma SPARK_Mode (On);

with KIDatentypen;

with StadtBauen, KINullwerteSetzen, Verbesserungen, LeseKarten, LeseEinheitenGebaut;

package body KISiedlerAufgabeDurchfuehren is

   procedure SiedlerAufgabeDurchfuehren
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      AufgabeDurchführen := True;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Stadt_Bauen =>
            StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern    => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzenExtern => 0);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;            
            
         when KIDatentypen.Verbesserung_Anlegen =>
            AufgabeDurchführen := WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Flucht =>
            null;
            
         when KIDatentypen.Einheit_Heilen =>
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Heilen);
            
         when KIDatentypen.Einheit_Festsetzen =>
            AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       BefehlExtern             => GlobaleDatentypen.Verschanzen);
            
         when KIDatentypen.Einheit_Verbessern =>
            null;
            
         when others =>
            null;
      end case;
      
      case
        AufgabeDurchführen
      is
         when True =>
            null;
            
         when False =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Nicht_Vorhanden;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
      end case;
      
   end SiedlerAufgabeDurchfuehren;
   
   
   
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
                                                   BefehlExtern             => GlobaleDatentypen.Mine_Bauen) = True
            then
               AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          BefehlExtern             => GlobaleDatentypen.Mine_Bauen);
               return True;
         
            elsif
              Grund = GlobaleDatentypen.Eis
              and
                Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   BefehlExtern             => GlobaleDatentypen.Festung_Bauen) = True
            then
               AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          BefehlExtern             => GlobaleDatentypen.Festung_Bauen);
               return True;
         
            elsif
              Verbesserungen.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BefehlExtern             => GlobaleDatentypen.Farm_Bauen) = True
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

end KISiedlerAufgabeDurchfuehren;
