pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Calendar; use Ada.Calendar;

with MenueDatentypen;
with ZahlenDatentypen;
with GlobaleTexte;

with SchreibeKarten;
with SchreibeWichtiges;

with AuswahlMenues;
with Fehler;
with Karten;
with Ladezeiten;

package body DebugmenueSFML is

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DebugmenüSchleife:
      loop
         
         RückgabeDebugmenü := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Debug_Menü_Enum);

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
               Fehler.LogikFehler (FehlermeldungExtern => "DebugmenueSFML.Debugmenü - Keine gültige Menürückgabe.");
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
      
      DiplomatischenStatusÄndern (NeuerStatusExtern => SystemDatentypen.Neutral_Enum);
      
   end KarteAufdecken;
   
   
   
   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum)
   is begin
      
      RassenErsteSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         RassenZweiteSchleife:
         for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
            
            SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := NeuerStatusExtern;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end DiplomatischenStatusÄndern;
   
   
   
   procedure LadezeitenAnzegien
   is begin
      
      Put_Line ("Generierungszeit der Spielwelt:");
      Gesamtzeit := 0.00;
      WelcherText := 2;
      
      LadezeitenSpielweltSchleife:
      for LadezeitenSpielweltSchleifenwert in Ladezeiten.SpielweltErstellenArray'Range (1) loop
         
         Put (To_Wide_Wide_String (Source => GlobaleTexte.Ladezeit (WelcherText)) & ": ");
         
         Zwischenzeit
           := Float (Ladezeiten.SpielweltErstellen (LadezeitenSpielweltSchleifenwert, SystemDatentypen.Endwert_Enum) - Ladezeiten.SpielweltErstellen (LadezeitenSpielweltSchleifenwert, SystemDatentypen.Anfangswert_Enum));
         
         AnzeigeFloat.Put (Item => Zwischenzeit,
                           Fore => 1,
                           Aft  => 6,
                           Exp  => 0);
         New_Line;
         
         Gesamtzeit := Gesamtzeit + Zwischenzeit;
         WelcherText := WelcherText + 1;
         
      end loop LadezeitenSpielweltSchleife;
      
      Put ("Gesamtzeit: ");
      AnzeigeFloat.Put (Item => Gesamtzeit,
                        Fore => 1,
                        Aft  => 6,
                        Exp  => 0);
      
      New_Line;
      New_Line;
      
      Put_Line ("Rechenzeit der KI:");
      Gesamtzeit := 0.00;
      
      KIZeitenSchleife:
      for KIZeitenSchleifenwert in Ladezeiten.KIZeitenArray'Range (1) loop
         
         
         case
           SpielVariablen.RassenImSpiel (KIZeitenSchleifenwert)
         is
            when RassenDatentypen.KI_Spieler_Enum =>
               Put (KIZeitenSchleifenwert'Wide_Wide_Image & ": ");
         
               Zwischenzeit := Float (Ladezeiten.KIZeiten (KIZeitenSchleifenwert, SystemDatentypen.Endwert_Enum) - Ladezeiten.KIZeiten (KIZeitenSchleifenwert, SystemDatentypen.Anfangswert_Enum));
         
               AnzeigeFloat.Put (Item => Zwischenzeit,
                                 Fore => 1,
                                 Aft  => 6,
                                 Exp  => 0);
               New_Line;
         
               Gesamtzeit := Gesamtzeit + Zwischenzeit;
               
            when others =>
               null;
         end case;
         
      end loop KIZeitenSchleife;
      
      Put ("Gesamtzeit: ");
      AnzeigeFloat.Put (Item => Gesamtzeit,
                        Fore => 1,
                        Aft  => 6,
                        Exp  => 0);
      
      New_Line;
      New_Line;
      
      Put ("Rundenende: ");
      AnzeigeFloat.Put (Item => Float (Ladezeiten.RundenendeZeit (SystemDatentypen.Endwert_Enum) - Ladezeiten.RundenendeZeit (SystemDatentypen.Anfangswert_Enum)),
                        Fore => 1,
                        Aft  => 6,
                        Exp  => 0);
      
      New_Line;
      New_Line;
      
      Put ("Speichern/Laden: ");
      AnzeigeFloat.Put (Item => Float (Ladezeiten.SpeichernLaden (SystemDatentypen.Endwert_Enum) - Ladezeiten.SpeichernLaden (SystemDatentypen.Anfangswert_Enum)),
                        Fore => 1,
                        Aft  => 6,
                        Exp  => 0);
      
      New_Line;
      New_Line;
           
   end LadezeitenAnzegien;

end DebugmenueSFML;
