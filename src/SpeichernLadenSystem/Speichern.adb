pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, SystemDatentypen, KartenRecords, EinheitStadtRecords, WichtigeRecords, SystemKonstanten, SonstigeDatentypen, KartenDatentypen;

with Karten, Auswahl, Ladezeiten, Informationen, SpeichernLadenAllgemein, Karte;

package body Speichern is

   procedure SpeichernNeu
     (AutospeichernExtern : in Boolean)
   is begin

      case
        SpielstandNameFestlegen (AutospeichernExtern => AutospeichernExtern)
      is
         when False =>
            return;
              
         when True =>
            null;
      end case;

      Ladezeiten.EinzelneZeiten (Ladezeiten.Speicherzeit, SystemDatentypen.Anfangswert) := Clock;
      
      Create (File => DateiSpeichernNeu,
              Mode => Out_File,
              Name => "Spielstand/" & Encode (Item => (To_Wide_Wide_String (Source => SpeichernLadenAllgemein.SpielstandName))));
      
      SonstigesSpeichern;
      KarteSpeichern;
      RassenGrenzenSpeichern;
      EinheitenSpeichern;
      StädteSpeichern;
      WichtigesSpeichern;
      DiplomatieSpeichern;
      CursorSpeichern;
      
      Close (File => DateiSpeichernNeu);
         
      Ladezeiten.EinzelneZeiten (Ladezeiten.Speicherzeit, SystemDatentypen.Endwert) := Clock;
      
      case
        AutospeichernExtern
      is
         when True =>
            Ladezeiten.AnzeigeEinzelneZeitOhneWarten (WelcheZeitExtern => Ladezeiten.Speicherzeit);
            
         when False =>
            Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Speicherzeit);
      end case;
   
   end SpeichernNeu;
   
   
   
   procedure SonstigesSpeichern
   is begin
      
      Wide_Wide_String'Write (Stream (File => DateiSpeichernNeu),
                              Informationen.Versionsnummer);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiSpeichernNeu),
                                        GlobaleVariablen.IronmanName);
      
      Positive'Write (Stream (File => DateiSpeichernNeu),
                      GlobaleVariablen.RundenAnzahl);
      
      Natural'Write (Stream (File => DateiSpeichernNeu),
                     GlobaleVariablen.Rundengrenze);
      
      SonstigeDatentypen.Rassen_Enum'Write (Stream (File => DateiSpeichernNeu),
                                           GlobaleVariablen.RasseAmZugNachLaden);
      
      SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                                 GlobaleVariablen.Schwierigkeitsgrad);
      
      Boolean'Write (Stream (File => DateiSpeichernNeu),
                     GlobaleVariablen.Gewonnen);
      
      Boolean'Write (Stream (File => DateiSpeichernNeu),
                     GlobaleVariablen.WeiterSpielen);
      
   end SonstigesSpeichern;
   
   
   
   procedure KarteSpeichern
   is begin
      
      KartenDatentypen.Kartenform_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                         Karten.Kartenform);
      KartenDatentypen.Kartengröße_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                            Karten.Kartengröße);
      
      Positive'Write (Stream (File => DateiSpeichernNeu),
                      Karte.SichtweiteFestlegen);
      Positive'Write (Stream (File => DateiSpeichernNeu),
                      Karte.BewegungsfeldFestlegen);
      
      case
        Karten.Kartengröße
      is
         when KartenDatentypen.Karte_Nutzer =>
            Karten.KartengrößenRecord'Write (Stream (File => DateiSpeichernNeu),
                                               Karten.Kartengrößen (KartenDatentypen.Karte_Nutzer));
            
         when others =>
            null;
      end case;

      EAchseBisBodenSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseBisBodenSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseBisBodenSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

               KartenRecords.KartenRecord'Write (Stream (File => DateiSpeichernNeu),
                                                 Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseBisBodenSchleife;
         end loop YAchseBisBodenSchleife;
      end loop EAchseBisBodenSchleife;
      
   end KarteSpeichern;
   
   
   
   procedure RassenGrenzenSpeichern
   is begin
      
      SonstigeDatentypen.RassenImSpielArray'Write (Stream (File => DateiSpeichernNeu),
                                                  GlobaleVariablen.RassenImSpiel);
      
      GrenzenRassenSchleife:
      for GrenzenRassenSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         WichtigeRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernNeu),
                                              GlobaleVariablen.Grenzen (GrenzenRassenSchleifenwert));
         
      end loop GrenzenRassenSchleife;
      
   end RassenGrenzenSpeichern;
   
   
   
   procedure EinheitenSpeichern
   is begin
      
      EinheitenRassenSchleife:
      for RasseEinheitenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop

         case
           GlobaleVariablen.RassenImSpiel (RasseEinheitenSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseEinheitenSchleifenwert).Einheitengrenze loop
                  
                  EinheitStadtRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                                   GlobaleVariablen.EinheitenGebaut (RasseEinheitenSchleifenwert, EinheitNummerSchleifenwert));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      
   end EinheitenSpeichern;
   
   
   
   procedure StädteSpeichern
   is begin
      
      StadtRassenSchleife:
      for RasseStadtSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseStadtSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;

            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseStadtSchleifenwert).Städtegrenze loop
                  
                  EinheitStadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                               GlobaleVariablen.StadtGebaut (RasseStadtSchleifenwert, StadtNummerSchleifenwert));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      
   end StädteSpeichern;
   
   
   
   procedure WichtigesSpeichern
   is begin
      
      WichtigesSchleife:
      for RasseWichtigesSchleifenwert in GlobaleVariablen.WichtigesArray'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseWichtigesSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               WichtigeRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernNeu),
                                                      GlobaleVariablen.Wichtiges (RasseWichtigesSchleifenwert));
         end case;
         
      end loop WichtigesSchleife;
      
   end WichtigesSpeichern;
   
   
   
   procedure DiplomatieSpeichern
   is begin
      
      DiplomatieSchleifeAußen:
      for RasseDiplomatieEinsSchleifenwert in GlobaleVariablen.DiplomatieArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseDiplomatieEinsSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;

            when others =>
               DiplomatieSchleifeInnen:
               for RasseDiplomatieZweiSchleifenwert in GlobaleVariablen.DiplomatieArray'Range (2) loop

                  case
                    GlobaleVariablen.RassenImSpiel (RasseDiplomatieZweiSchleifenwert)
                  is
                     when SonstigeDatentypen.Leer =>
                        null;
                     
                     when others =>
                        WichtigeRecords.DiplomatieRecord'Write (Stream (File => DateiSpeichernNeu),
                                                                GlobaleVariablen.Diplomatie (RasseDiplomatieEinsSchleifenwert, RasseDiplomatieZweiSchleifenwert));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      
   end DiplomatieSpeichern;
   
   
   
   procedure CursorSpeichern
   is begin
      
      CursorSchleife:
      for RasseCursorSchleifenwert in GlobaleVariablen.CursorImSpielArray'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseCursorSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               KartenRecords.CursorRecord'Write (Stream (File => DateiSpeichernNeu),
                                                 GlobaleVariablen.CursorImSpiel (RasseCursorSchleifenwert));
         end case;
         
      end loop CursorSchleife;
      
   end CursorSpeichern;
   
   
   
   function SpielstandNameFestlegen
     (AutospeichernExtern : in Boolean)
        return Boolean
   is begin
      
      case
        AutospeichernExtern
      is
         when False =>
            return NameNutzer;

         when True =>
            NameAutoSpeichern;
            return True;
      end case;
      
   end SpielstandNameFestlegen;
   
   
   
   function NameNutzer
     return Boolean
   is begin
      
      if
        To_Wide_Wide_String (Source => GlobaleVariablen.IronmanName) /= SystemKonstanten.LeerString
      then
         SpeichernLadenAllgemein.SpielstandName := GlobaleVariablen.IronmanName;
               
      else
         -- Anzeige der vorhandenen Spielstände einbauen
         case
           SpeichernLadenAllgemein.SpielstandNameErmitteln
         is
            when True =>
               if
                 Auswahl.AuswahlJaNein (FrageZeileExtern => 18) = SystemKonstanten.JaKonstante
               then
                  null;
                     
               else
                  return False;
               end if;

            when False =>
               null;
         end case;
      end if;
      
      return True;
      
   end NameNutzer;
   
   
   
   procedure NameAutoSpeichern
   is begin
      
      if
        To_Wide_Wide_String (Source => GlobaleVariablen.IronmanName) /= SystemKonstanten.LeerString
      then
         SpeichernLadenAllgemein.SpielstandName := GlobaleVariablen.IronmanName;
               
      else
         SpeichernLadenAllgemein.SpielstandName := To_Unbounded_Wide_Wide_String (Source => "Autospeichern" & AutospeichernWert'Wide_Wide_Image);
         if
           GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave = 1
         then
            null;

         elsif
           AutospeichernWert <= GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave - 1
         then
            AutospeichernWert := AutospeichernWert + 1;
                  
         else
            AutospeichernWert := 1;
         end if;
      end if;
      
   end NameAutoSpeichern;
   
   

   procedure AutoSpeichern
   is begin
      
      case
        GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave
      is
         when Natural'First =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        GlobaleVariablen.RundenAnzahl mod GlobaleVariablen.NutzerEinstellungen.RundenBisAutosave
      is
         when 0 =>
            SpeichernNeu (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end Speichern;
