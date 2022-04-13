pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with TastenbelegungDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with StadtBauen;
with Aufgaben;
with EinheitenErzeugenEntfernen;
with Fehler;

with KIVorhandeneAufgaben;
with KIAufgabeFestlegen;
with KIAufgabeUmsetzen;

package body KIAufgabenPlanung is
   
   procedure AufgabeErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- Muss für die Schleife weiter unten auf den ersten Wert gesetzt werden.
      GewählteAufgabe := KIDatentypen.Einheit_Aufgabe_Enum'First;
      Wichtigkeit := (others => EinheitStadtDatentypen.ProduktionSonstiges'First);
            
      Wichtigkeit (KIDatentypen.Tut_Nichts_Enum) := KIVorhandeneAufgaben.NichtsTun;
      Wichtigkeit (KIDatentypen.Einheit_Auflösen_Enum) := KIVorhandeneAufgaben.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Heilen_Enum) := KIVorhandeneAufgaben.SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Festsetzen_Enum) := KIVorhandeneAufgaben.SichBefestigen;
      Wichtigkeit (KIDatentypen.Einheit_Verbessern_Enum) := KIVorhandeneAufgaben.SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Flucht_Enum) := KIVorhandeneAufgaben.Fliehen;
      
      EinheitSpezifischeAufgabenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      AufgabenSortieren;
      
      AufgabeFestlegen (GewählteAufgabeExtern    => GewählteAufgabe,
                        EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end AufgabeErmitteln;
   
   
   
   procedure EinheitSpezifischeAufgabenErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitStadtDatentypen.Arbeiter_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bauen_Enum) := KIVorhandeneAufgaben.NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Anlegen_Enum) := KIVorhandeneAufgaben.StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitStadtDatentypen.Nahkämpfer_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bewachen_Enum) := KIVorhandeneAufgaben.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Zerstören_Enum) := KIVorhandeneAufgaben.StadtUmgebungZerstören;
            Wichtigkeit (KIDatentypen.Angreifen_Enum) := KIVorhandeneAufgaben.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Erkunden_Enum) := KIVorhandeneAufgaben.Erkunden;
            
         when EinheitStadtDatentypen.Fernkämpfer_Enum =>
            null;
            
         when EinheitStadtDatentypen.Beides_Enum =>
            null;
            
         when EinheitStadtDatentypen.Sonstiges_Enum =>
            null;
            
         when EinheitStadtDatentypen.Leer_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIAufgabenPlanung.EinheitSpezifischeAufgabenErmitteln - KI hat keine Einheit ausgewählt.");
      end case;
      
   end EinheitSpezifischeAufgabenErmitteln;
   
   
   
   procedure AufgabenSortieren
   is begin
      
      WichtigkeitEinsSchleife:
      for WichtigkeitEinsSchleifenwert in WichtigkeitArray'Range loop
         WichtigkeitZweiSchleife:
         for WichtigkeitZweiSchleifenwert in WichtigkeitArray'Range loop
         
            if
              Wichtigkeit (WichtigkeitEinsSchleifenwert) > Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (GewählteAufgabe) < Wichtigkeit (WichtigkeitEinsSchleifenwert)
            then
               GewählteAufgabe := WichtigkeitEinsSchleifenwert;
               
            elsif
              Wichtigkeit (WichtigkeitEinsSchleifenwert) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (GewählteAufgabe) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
            then
               GewählteAufgabe := WichtigkeitZweiSchleifenwert;
               exit WichtigkeitZweiSchleife;
            
            else
               null;
            end if;
         
         end loop WichtigkeitZweiSchleife;
      end loop WichtigkeitEinsSchleife;
      
   end AufgabenSortieren;
   
   
   
   procedure AufgabeFestlegen
     (GewählteAufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        GewählteAufgabeExtern
      is
         when KIDatentypen.Stadt_Bauen_Enum =>
            KIAufgabeFestlegen.StadtBauenPrüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Anlegen_Enum =>
            KIAufgabeFestlegen.StadtUmgebungVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Auflösen_Enum =>
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Flucht_Enum =>
            KIAufgabeFestlegen.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Heilen_Enum =>
            KIAufgabeFestlegen.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Festsetzen_Enum =>
            KIAufgabeFestlegen.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Verbessern_Enum =>
            KIAufgabeFestlegen.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen_Enum =>
            KIAufgabeFestlegen.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören_Enum =>
            KIAufgabeFestlegen.StadtUmgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen_Enum =>
            KIAufgabeFestlegen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Erkunden_Enum =>
            KIAufgabeFestlegen.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Nichts tun und alles was noch nicht programmiert ist.
         when others =>
            KIAufgabeFestlegen.KeineAufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end AufgabeFestlegen;
   
   
   
   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      AufgabeDurchführen := True;
      
      case
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIDatentypen.Stadt_Bauen_Enum =>
            AufgabeDurchführen := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum);
            
         when KIDatentypen.Verbesserung_Anlegen_Enum =>
            AufgabeDurchführen := KIAufgabeUmsetzen.WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören_Enum =>
            null;
            
         when KIDatentypen.Flucht_Enum =>
            null;
            
         when KIDatentypen.Einheit_Heilen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Heilen_Enum);
            
         when KIDatentypen.Einheit_Festsetzen_Enum =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => TastenbelegungDatentypen.Verschanzen_Enum);
            
         when KIDatentypen.Einheit_Verbessern_Enum =>
            AufgabeDurchführen := KIAufgabeUmsetzen.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen_Enum =>
            KIAufgabeFestlegen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigen_Enum =>
            null;
            
         when KIDatentypen.Erkunden_Enum =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts_Enum);
            
            -- Nichts tun und alles was noch nicht programmiert ist.
         when others =>
            null;
      end case;
      
      case
        AufgabeDurchführen
      is
         when True =>
            null;
            
         when False =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts_Enum);
      end case;
      
   end AufgabeUmsetzen;

end KIAufgabenPlanung;
