pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenRecordKonstanten;
with AufgabenDatentypen;
  
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with Fehler;

with KIDatentypen; use KIDatentypen;

with KIEinheitAufgabeNichtsLogik;
with KIEinheitAufgabeBefestigenLogik;
with KIEinheitAufgabeFliehenLogik;
with KIEinheitAufgabeHeilenLogik;
with KIEinheitAufgabeAngreifenLogik;
with KIEinheitAufgabeErkundenLogik;
with KIEinheitAufgabeAufloesenLogik;
with KIEinheitAufgabePluendernLogik;
with KIEinheitAufgabeModernisierenLogik;
with KIEinheitAufgabeSiedelnLogik;
with KIEinheitAufgabeBewachenLogik;
with KIEinheitAufgabeVerbesserungenLogik;
with KIEinheitAufgabeAngriffskriegLogik;
with KIEinheitAufgabeVerteidigenLogik;
with KIEinheitAufgabeVerteidigungskriegLogik;
with KIEinheitAufgabeTransporterLogik;
with KIEinheitFestlegenSiedelnLogik;
with KIEinheitFestlegenVerbesserungenLogik;
with KIEinheitFestlegenFliehenLogik;
with KIEinheitFestlegenHeilenLogik;
with KIEinheitFestlegenBefestigenLogik;
with KIEinheitFestlegenModernisierenLogik;
with KIEinheitFestlegenBewachenLogik;
with KIEinheitFestlegenPluendernLogik;
with KIEinheitFestlegenAngreifenLogik;
with KIEinheitFestlegenErkundenLogik;
with KIEinheitFestlegenNichtsLogik;
with KIEinheitFestlegenVerteidigenLogik;
with KIEinheitFestlegenAngriffskriegLogik;
with KIEinheitFestlegenVerteidigungskriegLogik;
with KIEinheitFestlegenAufloesenLogik;
with KIEinheitFestlegenTransporterLogik;

package body KIEinheitAufgabenplanungLogik is
   
   -- Bei den Prüfungen zurückgeben: -1 wenn es nicht möglich sein soll, 0 wenn keine richtige Prüfung vorhanden ist und 1 .. 100 für die reguläre Bewertung.
   -- Später ändern? äöü
   procedure AufgabeErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- Wird benötigt, da je nach Einheitenart nicht alle Arrayteile neu gesetzt werden.
      Wichtigkeit := (others => KIDatentypen.AufgabenWichtigkeitKlein'First);
                  
      Wichtigkeit (KIDatentypen.Tut_Nichts_Enum) := KIEinheitAufgabeNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      Wichtigkeit (KIDatentypen.Einheit_Auflösen_Enum) := KIEinheitAufgabeAufloesenLogik.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Heilen_Enum) := KIEinheitAufgabeHeilenLogik.SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Festsetzen_Enum) := KIEinheitAufgabeBefestigenLogik.SichBefestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Verbessern_Enum) := KIEinheitAufgabeModernisierenLogik.SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Flucht_Enum) := KIEinheitAufgabeFliehenLogik.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Hier später besser aufteilen. äöü
      Wichtigkeit (KIDatentypen.Verteidigen_Enum) := KIEinheitAufgabeVerteidigenLogik.Verteidigen;
      Wichtigkeit (KIDatentypen.Auf_Transporter_Warten_Enum) := KIEinheitAufgabeTransporterLogik.AbholungAbwarten;
      Wichtigkeit (KIDatentypen.Angriffskrieg_Vorbereiten_Enum) := KIEinheitAufgabeAngriffskriegLogik.AngriffskriegVorbereiten;
      Wichtigkeit (KIDatentypen.Verteidigungskrieg_Vorbereiten_Enum) := KIEinheitAufgabeVerteidigungskriegLogik.VerteidigungskriegVorbereiten;
      -- Hier später besser aufteilen. äöü
      
      EinheitSpezifischeAufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      AufgabeFestlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end AufgabeErmitteln;
   
   
   procedure EinheitSpezifischeAufgabeErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bauen_Enum) := KIEinheitAufgabeSiedelnLogik.NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Anlegen_Enum) := KIEinheitAufgabeVerbesserungenLogik.StadtumgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Nahkämpfer_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bewachen_Enum) := KIEinheitAufgabeBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Zerstören_Enum) := KIEinheitAufgabePluendernLogik.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Angreifen_Enum) := KIEinheitAufgabeAngreifenLogik.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Erkunden_Enum) := KIEinheitAufgabeErkundenLogik.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Später noch Extraberechnungen für Fernkämpfer im Angriff durchführen lassen. Aktuell ist das ja eh nicht implementiert. äöü
         when EinheitenDatentypen.Fernkämpfer_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bewachen_Enum) := KIEinheitAufgabeBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Zerstören_Enum) := KIEinheitAufgabePluendernLogik.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Angreifen_Enum) := KIEinheitAufgabeAngreifenLogik.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Erkunden_Enum) := KIEinheitAufgabeErkundenLogik.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Beides_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bewachen_Enum) := KIEinheitAufgabeBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Zerstören_Enum) := KIEinheitAufgabePluendernLogik.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Angreifen_Enum) := KIEinheitAufgabeAngreifenLogik.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Erkunden_Enum) := KIEinheitAufgabeErkundenLogik.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.PZB_Enum'Range =>
            null;
            
         when EinheitenDatentypen.Cheat_Enum =>
            -- Wenn man Debug nutzt, dann auch für die KI die Cheateinheit aktivieren? äöü
            Fehler.LogikFehler (FehlermeldungExtern => "KIAufgabenPlanung.EinheitSpezifischeAufgabenErmitteln: KI hat Cheateinheit ausgewählt.");
            
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIAufgabenPlanung.EinheitSpezifischeAufgabenErmitteln: Leere Einheitart.");
      end case;
      
   end EinheitSpezifischeAufgabeErmitteln;
   
   
   
   -- Das hier nochmal überarbeiten. äöü
   function AufgabeAuswählen
     return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      WelcheAufgabe := KIDatentypen.Einheit_Aufgabe_Enum'First;
      
      AufgabeAuswählenSchleife:
      for AufgabeAuswählenSchleifenwert in WichtigkeitArray'Range loop
         
         if
           Wichtigkeit (AufgabeAuswählenSchleifenwert) = -1
         then
            null;
            
         elsif
           WelcheAufgabe /= KIDatentypen.Leer_Aufgabe_Enum
           and then
             Wichtigkeit (WelcheAufgabe) < Wichtigkeit (AufgabeAuswählenSchleifenwert)
         then
            WelcheAufgabe := AufgabeAuswählenSchleifenwert;
            
         elsif
           WelcheAufgabe = KIDatentypen.Leer_Aufgabe_Enum
           and
             Wichtigkeit (AufgabeAuswählenSchleifenwert) > -1
         then
            WelcheAufgabe := AufgabeAuswählenSchleifenwert;
            
         else
            null;
         end if;
         
      end loop AufgabeAuswählenSchleife;
      
      return WelcheAufgabe;
      
   end AufgabeAuswählen;
   
   
   
   procedure AufgabeFestlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      AufgabeFestlegenSchleife:
      loop
         
         Aufgabe := AufgabeAuswählen;
      
         case
           Aufgabe
         is
            when KIDatentypen.Stadt_Bauen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenSiedelnLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Verbesserung_Anlegen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenVerbesserungenLogik.StadtumgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Auflösen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenAufloesenLogik.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Flucht_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenFliehenLogik.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Heilen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenHeilenLogik.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Festsetzen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenBefestigenLogik.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Verbessern_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenModernisierenLogik.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Stadt_Bewachen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenBewachenLogik.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Verbesserung_Zerstören_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenPluendernLogik.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Angreifen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenAngreifenLogik.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Erkunden_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenErkundenLogik.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Verteidigen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenVerteidigenLogik.Verteidigen;
               
               -- Hier müsste ich erst das Ziel ermitteln lassen und dann entsprechend die Aufgabe setzen. Bin mal gespannt wie ich das löse. äöü
               -- Eventuell eine KIBeschäftigungNachfolger einbauen und dann entsprechnd verschieben? Wie bei VerbesserungenNachfolger. äöü
            when KIDatentypen.Auf_Transporter_Warten_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenTransporterLogik.AbholungAbwarten;
               
            when KIDatentypen.Angriffskrieg_Vorbereiten_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenAngriffskriegLogik.AngriffskriegVorbereiten;
            
            when KIDatentypen.Verteidigungskrieg_Vorbereiten_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenVerteidigungskriegLogik.VerteidigungskriegVorbereiten;
               
            when KIDatentypen.Tut_Nichts_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            when KIDatentypen.Planet_Vernichten_Enum =>
               null;
            
            when KIDatentypen.Leer_Aufgabe_Enum =>
               exit AufgabeFestlegenSchleife;
         end case;
      
         case
           AufgabeFestgelegt
         is
            when True =>
               exit AufgabeFestlegenSchleife;
            
            when False =>
               -- Hier auf Leer setzen, für den Fall dass es Probleme in den Festlegungen gibt.
               SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
               SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
               SchreibeEinheitenGebaut.KIVerbesserung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       BeschäftigungExtern      => AufgabenDatentypen.Leer_Aufgabe_Enum);
               Wichtigkeit (Aufgabe) := -1;
         end case;
         
      end loop AufgabeFestlegenSchleife;
      
   end AufgabeFestlegen;

end KIEinheitAufgabenplanungLogik;
