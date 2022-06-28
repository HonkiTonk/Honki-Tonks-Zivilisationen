pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
  
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with EinheitenErzeugenEntfernen;
with Fehler;

with KIDatentypen; use KIDatentypen;

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
with KIEinheitFestlegenSiedeln;
with KIEinheitFestlegenVerbesserungen;
with KIEinheitFestlegenFliehen;
with KIEinheitFestlegenHeilen;
with KIEinheitFestlegenBefestigen;
with KIEinheitFestlegenModernisieren;
with KIEinheitFestlegenBewachen;
with KIEinheitFestlegenPluendern;
with KIEinheitFestlegenAngreifen;
with KIEinheitFestlegenErkunden;
with KIEinheitFestlegenNichts;

package body KIAufgabenPlanung is
   
   -- Bei den Prüfungen zurückgeben: -1 wenn es nicht möglich sein soll, 0 wenn keine richtige Prüfung vorhanden ist und 1 .. 100 für die reguläre Bewertung.
   procedure AufgabeErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      -- Wird benötigt, da je nach Einheitenart nicht alle Arrayteile neu gesetzt werden.
      Wichtigkeit := (others => KIDatentypen.AufgabenWichtigkeitKlein'First);
                  
      Wichtigkeit (KIDatentypen.Tut_Nichts_Enum) := KIEinheitAufgabeNichts.NichtsTun (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      Wichtigkeit (KIDatentypen.Einheit_Auflösen_Enum) := KIEinheitAufgabeAufloesen.EinheitAuflösen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Heilen_Enum) := KIEinheitAufgabeHeilen.SichHeilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Festsetzen_Enum) := KIEinheitAufgabeBefestigen.SichBefestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Einheit_Verbessern_Enum) := KIEinheitAufgabeModernisieren.SichVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Wichtigkeit (KIDatentypen.Flucht_Enum) := KIEinheitAufgabeFliehen.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
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
            Wichtigkeit (KIDatentypen.Stadt_Bauen_Enum) := KIEinheitAufgabeSiedeln.NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Anlegen_Enum) := KIEinheitAufgabeVerbesserungen.StadtumgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Nahkämpfer_Enum =>
            Wichtigkeit (KIDatentypen.Stadt_Bewachen_Enum) := KIEinheitAufgabeBewachen.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Verbesserung_Zerstören_Enum) := KIEinheitAufgabePluendern.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Angreifen_Enum) := KIEinheitAufgabeAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            Wichtigkeit (KIDatentypen.Erkunden_Enum) := KIEinheitAufgabeErkunden.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Fernkämpfer_Enum =>
            null;
            
         when EinheitenDatentypen.Beides_Enum =>
            null;
            
         when EinheitenDatentypen.Sonstiges_Enum =>
            null;
            
         when EinheitenDatentypen.Cheat_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIAufgabenPlanung.EinheitSpezifischeAufgabenErmitteln - KI hat Cheateinheit ausgewählt.");
      end case;
      
   end EinheitSpezifischeAufgabeErmitteln;
   
   
   
   ------------------------------------------ Das hier nochmal überarbeiten.
   function AufgabeAuswählen
     return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      WelcheAufgabe := WichtigkeitArray'First;
      AufgabenDurchgegangen := 1;
      
      AufgabeAuswählenSchleife:
      for AufgabeAuswählenSchleifenwert in WichtigkeitArray'Range loop
         
         if
           Wichtigkeit (AufgabeAuswählenSchleifenwert) = -1
         then
            AufgabenDurchgegangen := AufgabenDurchgegangen + 1;
           
         elsif
           Wichtigkeit (WelcheAufgabe) < Wichtigkeit (AufgabeAuswählenSchleifenwert)
         then
            WelcheAufgabe := AufgabeAuswählenSchleifenwert;
            
         else
            null;
         end if;
         
      end loop AufgabeAuswählenSchleife;
      
      if
        AufgabenDurchgegangen >= WichtigkeitArray'Length
      then
         WelcheAufgabe := KIDatentypen.Leer_Aufgabe_Enum;
         
      else
         null;
      end if;
      
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
               AufgabeFestgelegt := KIEinheitFestlegenSiedeln.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Verbesserung_Anlegen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenVerbesserungen.StadtumgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Auflösen_Enum =>
               -- Hier wird keine spezifische KILösung benötigt, da einfach die Standardentfernprozedur verwendet wird.
               AufgabeFestgelegt := True;
               EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Flucht_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenFliehen.Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Heilen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenHeilen.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Festsetzen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenBefestigen.Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Einheit_Verbessern_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenModernisieren.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Stadt_Bewachen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenBewachen.StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Verbesserung_Zerstören_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenPluendern.StadtumgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Angreifen_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenAngreifen.Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Erkunden_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenErkunden.Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Verteidigen_Enum | KIDatentypen.Auf_Transporter_Warten_Enum =>
               AufgabeFestgelegt := False;
            
            when KIDatentypen.Tut_Nichts_Enum =>
               AufgabeFestgelegt := KIEinheitFestlegenNichts.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            when KIDatentypen.Leer_Aufgabe_Enum =>
               exit AufgabeFestlegenSchleife;
               
         end case;
      
         case
           AufgabeFestgelegt
         is
            when True =>
               exit AufgabeFestlegenSchleife;
            
            when False =>
               Wichtigkeit (Aufgabe) := -1;
         end case;
         
      end loop AufgabeFestlegenSchleife;
      
   end AufgabeFestlegen;

end KIAufgabenPlanung;
