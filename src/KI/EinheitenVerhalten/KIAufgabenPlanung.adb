pragma SPARK_Mode (On);

with EinheitStadtDatentypen, SystemDatentypen;
use EinheitStadtDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank, LeseEinheitenGebaut;

with StadtBauen, Aufgaben, EinheitenErzeugenEntfernen;

with KIVorhandeneAufgaben, KIAufgabeFestlegen, KIAufgabeUmsetzen;

package body KIAufgabenPlanung is
   
   procedure AufgabeErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      -- Muss für die Schleife weiter unten auf den ersten Wert gesetzt werden.
      GewählteAufgabe := KIDatentypen.Einheit_Aufgabe_Enum'First;
      Wichtigkeit := (others => EinheitStadtDatentypen.ProduktionSonstiges'First);
            
      Wichtigkeit (KIDatentypen.Tut_Nichts) := KIVorhandeneAufgaben.NichtsTun;
      Wichtigkeit (KIDatentypen.Einheit_Auflösen) := KIVorhandeneAufgaben.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Heilen) := KIVorhandeneAufgaben.SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Festsetzen) := KIVorhandeneAufgaben.SichBefestigen;
      Wichtigkeit (KIDatentypen.Einheit_Verbessern) := KIVorhandeneAufgaben.SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Flucht) := KIVorhandeneAufgaben.Fliehen;
      
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
         when EinheitStadtDatentypen.Arbeiter =>
            Wichtigkeit (KIDatentypen.Stadt_Bauen) := KIVorhandeneAufgaben.NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Anlegen) := KIVorhandeneAufgaben.StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitStadtDatentypen.Nahkämpfer =>
            Wichtigkeit (KIDatentypen.Stadt_Bewachen) := KIVorhandeneAufgaben.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Zerstören) := KIVorhandeneAufgaben.StadtUmgebungZerstören;
            Wichtigkeit (KIDatentypen.Angreifen) := KIVorhandeneAufgaben.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Erkunden) := KIVorhandeneAufgaben.Erkunden;
            
         when EinheitStadtDatentypen.Fernkämpfer =>
            null;
            
         when EinheitStadtDatentypen.Beides =>
            null;
            
         when EinheitStadtDatentypen.Sonstiges =>
            null;
            
         when EinheitStadtDatentypen.Leer =>
            -- Sollte niemals eintreten.
            raise Program_Error;
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
         when KIDatentypen.Stadt_Bauen =>
            KIAufgabeFestlegen.StadtBauenPrüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Anlegen =>
            KIAufgabeFestlegen.StadtUmgebungVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Auflösen =>
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Flucht =>
            KIAufgabeFestlegen.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Heilen =>
            KIAufgabeFestlegen.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Festsetzen =>
            KIAufgabeFestlegen.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Einheit_Verbessern =>
            KIAufgabeFestlegen.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen =>
            KIAufgabeFestlegen.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören =>
            KIAufgabeFestlegen.StadtUmgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen =>
            KIAufgabeFestlegen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Erkunden =>
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
         when KIDatentypen.Stadt_Bauen =>
            AufgabeDurchführen := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Stadt_Bewachen =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => SystemDatentypen.Verschanzen);
            
         when KIDatentypen.Verbesserung_Anlegen =>
            AufgabeDurchführen := KIAufgabeUmsetzen.WelcheVerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verbesserung_Zerstören =>
            null;
            
         when KIDatentypen.Flucht =>
            null;
            
         when KIDatentypen.Einheit_Heilen =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => SystemDatentypen.Heilen);
            
         when KIDatentypen.Einheit_Festsetzen =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => SystemDatentypen.Verschanzen);
            
         when KIDatentypen.Einheit_Verbessern =>
            AufgabeDurchführen := KIAufgabeUmsetzen.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Angreifen =>
            KIAufgabeFestlegen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when KIDatentypen.Verteidigen =>
            null;
            
         when KIDatentypen.Erkunden =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts);
            
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
                                                    BeschäftigungExtern     => SystemDatentypen.Leer);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts);
      end case;
      
   end AufgabeUmsetzen;

end KIAufgabenPlanung;
