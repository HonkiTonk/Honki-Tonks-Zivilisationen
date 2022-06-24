pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with TastenbelegungDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with StadtBauen;
with Aufgaben;
with EinheitenErzeugenEntfernen;
with Fehler;

with KIDatentypen; use KIDatentypen;

with KIAufgabeFestlegen;
with KIAufgabeUmsetzen;
with KIEinheitAufgabeNichts;
with KIEinheitAufgabeBefestigen;
with KIEinheitAufgabeFliehen;
with KIEinheitAufgabeHeilen;
with KIEinheitAufgabeAngreifen;
with KIEinheitAufgabeErkunden;
with KIEinheitAufgabeAufloesen;
with KIEinheitAufgabePluendern;
with KIEinheitAufgabeModernisieren;
with KIEinheitAufgabeSiedeln;
with KIEinheitAufgabeBewachen;
with KIEinheitAufgabeVerbesserungen;

package body KIAufgabenPlanung is
   
   -- Bei den Prüfungen zurückgeben: -1 wenn es nicht möglich sein soll, 0 wenn keine richtige Prüfung vorhanden ist und 1 .. 100 für die reguläre Bewertung.
   procedure AufgabeErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Wichtigkeit := (others => KIDatentypen.AufgabenWichtigkeit'First);
                  
      Wichtigkeit (KIDatentypen.Tut_Nichts_Enum) := KIEinheitAufgabeNichts.NichtsTun (RasseExtern => EinheitRasseNummerExtern.Rasse);
      Wichtigkeit (KIDatentypen.Einheit_Auflösen_Enum) := KIEinheitAufgabeAufloesen.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Heilen_Enum) := KIEinheitAufgabeHeilen.SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Festsetzen_Enum) := KIEinheitAufgabeBefestigen.SichBefestigen;
      Wichtigkeit (KIDatentypen.Einheit_Verbessern_Enum) := KIEinheitAufgabeModernisieren.SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Flucht_Enum) := KIEinheitAufgabeFliehen.Fliehen;
      
      EinheitSpezifischeAufgabenErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      AufgabeFestlegen (GewählteAufgabeExtern    => AufgabenSortieren,
                        EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end AufgabeErmitteln;
   
   
   
   procedure EinheitSpezifischeAufgabenErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bauen_Enum) := KIEinheitAufgabeSiedeln.NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Anlegen_Enum) := KIEinheitAufgabeVerbesserungen.StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Nahkämpfer_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bewachen_Enum) := KIEinheitAufgabeBewachen.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Zerstören_Enum) := KIEinheitAufgabePluendern.StadtUmgebungZerstören;
            Wichtigkeit (KIDatentypen.Angreifen_Enum) := KIEinheitAufgabeAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Erkunden_Enum) := KIEinheitAufgabeErkunden.Erkunden;
            
         when EinheitenDatentypen.Fernkämpfer_Enum =>
            null;
            
         when EinheitenDatentypen.Beides_Enum =>
            null;
            
         when EinheitenDatentypen.Sonstiges_Enum =>
            null;
            
         when EinheitenDatentypen.Cheat_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIAufgabenPlanung.EinheitSpezifischeAufgabenErmitteln - KI hat Cheateinheit ausgewählt.");
            
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIAufgabenPlanung.EinheitSpezifischeAufgabenErmitteln - KI hat keine Einheit ausgewählt.");
      end case;
      
   end EinheitSpezifischeAufgabenErmitteln;
   
   
   
   function AufgabenSortieren
     return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      AufgabeAuswählen := KIDatentypen.Einheit_Aufgabe_Vorhanden_Enum'First;
      
      WichtigkeitEinsSchleife:
      for WichtigkeitEinsSchleifenwert in WichtigkeitArray'Range loop
         WichtigkeitZweiSchleife:
         for WichtigkeitZweiSchleifenwert in WichtigkeitArray'Range loop
         
            if
              Wichtigkeit (WichtigkeitEinsSchleifenwert) > Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (AufgabeAuswählen) < Wichtigkeit (WichtigkeitEinsSchleifenwert)
            then
               AufgabeAuswählen := WichtigkeitEinsSchleifenwert;
               
            elsif
              Wichtigkeit (WichtigkeitEinsSchleifenwert) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
              and
                Wichtigkeit (AufgabeAuswählen) < Wichtigkeit (WichtigkeitZweiSchleifenwert)
            then
               AufgabeAuswählen := WichtigkeitZweiSchleifenwert;
               exit WichtigkeitZweiSchleife;
            
            else
               null;
            end if;
         
         end loop WichtigkeitZweiSchleife;
      end loop WichtigkeitEinsSchleife;
      
      return AufgabeAuswählen;
      
   end AufgabenSortieren;
   
   
   
   procedure AufgabeFestlegen
     (GewählteAufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Vorhanden_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
            
         when KIDatentypen.Tut_Nichts_Enum | KIDatentypen.Verteidigen_Enum | KIDatentypen.Auf_Transporter_Warten_Enum =>
            KIAufgabeFestlegen.KeineAufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end AufgabeFestlegen;
   
   
   
   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
            
         when KIDatentypen.Tut_Nichts_Enum | KIDatentypen.Auf_Transporter_Warten_Enum | KIDatentypen.Einheit_Auflösen_Enum | KIDatentypen.Leer_Aufgabe_Enum =>
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