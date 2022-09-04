pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with ZahlenDatentypen;

with SchreibeKarten;
with SchreibeWichtiges;

with Auswahlaufteilungen;
with Fehler;
with Karten;

package body DebugmenueLogik is

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DebugmenüSchleife:
      loop
         
         RückgabeDebugmenü := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Debug_Menü_Enum);

         case
           RückgabeDebugmenü
         is
            when RueckgabeDatentypen.Menschen_Enum =>
               KarteAufdecken (RasseExtern => RasseExtern);
               
            when RueckgabeDatentypen.Kasrodiah_Enum =>
               SpielVariablen.Wichtiges (RasseExtern).Erforscht := (others => True);
               
            when RueckgabeDatentypen.Lasupin_Enum =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                            GeldZugewinnExtern  => ZahlenDatentypen.EigenerInteger'Last,
                                            RechnenSetzenExtern => False);
               
            when RueckgabeDatentypen.Lamustra_Enum =>
               SpielVariablen.Debug.Allgemeines := not SpielVariablen.Debug.Allgemeines;
               
            when RueckgabeDatentypen.Manuky_Enum =>
               SpielVariablen.Debug.VolleInformation := not SpielVariablen.Debug.VolleInformation;
               
            when RueckgabeDatentypen.Suroka_Enum =>
               SpielVariablen.Debug.Sieg := not SpielVariablen.Debug.Sieg;
               
            when RueckgabeDatentypen.Pryolon_Enum =>
               LadezeitenAnzegien;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
                  
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DebugmenueLogik.Debugmenü - Falsche Rückgabe.");
         end case;
      
      end loop DebugmenüSchleife;
      
   end Debugmenü;
   
   
   
   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop
            
               SchreibeKarten.Sichtbar (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                        RasseExtern       => RasseExtern,
                                        SichtbarExtern    => True);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
      DiplomatischenStatusÄndern (NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum);
      
   end KarteAufdecken;
   
   
   
   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
   is begin
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            if
              SpielVariablen.RassenImSpiel (RasseEinsSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
              or
                SpielVariablen.RassenImSpiel (RasseZweiSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
            then
               null;
               
            else
               SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := NeuerStatusExtern;
            end if;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end DiplomatischenStatusÄndern;
   
   
   
   procedure LadezeitenAnzegien
   is begin
      
      -- Hier einfach die zu prüfende Zeit einbauen, wenn es jemals einen Grund gibt die Zeit irgendwo zu messen.
      null;
           
   end LadezeitenAnzegien;

end DebugmenueLogik;
