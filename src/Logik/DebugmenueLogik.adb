pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with MenueDatentypen;
with ZahlenDatentypen;

with SchreibeWeltkarte;
with SchreibeWichtiges;

with AuswahlaufteilungLogik;
with Fehler;
with Weltkarte;

package body DebugmenueLogik is

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DebugmenüSchleife:
      loop
         
         RückgabeDebugmenü := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Debug_Menü_Enum);

         case
           RückgabeDebugmenü
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KarteAufdecken (RasseExtern => RasseExtern);
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               SpielVariablen.Wichtiges (RasseExtern).Erforscht := (others => True);
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                            GeldZugewinnExtern  => ZahlenDatentypen.EigenerInteger'Last,
                                            RechnenSetzenExtern => False);
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               SpielVariablen.Debug.Allgemeines := not SpielVariablen.Debug.Allgemeines;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               SpielVariablen.Debug.VolleInformation := not SpielVariablen.Debug.VolleInformation;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
                  
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "DebugmenueLogik.Debugmenü: Falsche Rückgabe: " & RückgabeDebugmenü'Wide_Wide_Image);
         end case;
      
      end loop DebugmenüSchleife;
      
   end Debugmenü;
   
   
   
   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in Weltkarte.KarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop
            
               SchreibeWeltkarte.Sichtbar (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
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
              SpielVariablen.Rassenbelegung (RasseEinsSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
              or
                SpielVariablen.Rassenbelegung (RasseZweiSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
            then
               null;
               
            else
               SpielVariablen.Diplomatie (RasseEinsSchleifenwert, RasseZweiSchleifenwert).AktuellerZustand := NeuerStatusExtern;
            end if;
            
         end loop RassenZweiteSchleife;
      end loop RassenErsteSchleife;
      
   end DiplomatischenStatusÄndern;

end DebugmenueLogik;
