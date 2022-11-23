with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with TextnummernKonstanten;
with GrafikDatentypen;
with VerzeichnisKonstanten;
with TextKonstanten;
with KartenKonstanten;
with StadtKonstanten;
with EinheitenKonstanten;

with LeseWeltkarteneinstellungen;
with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;
with SchreibeWichtiges;
with LeseGrenzen;
with SchreibeGrenzen;
with SchreibeDiplomatie;
with SchreibeCursor;
with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeAllgemeines;
with SchreibeRassenbelegung;

with LadezeitenLogik;
with JaNeinLogik;
with NachGrafiktask;
with SpielstandlisteLogik;

package body LadenLogik is
   
   function Laden
     return Boolean
   is begin
      
      Spielstandname := SpielstandlisteLogik.Spielstandliste (SpeichernLadenExtern => False);
      
      if
        Spielstandname = TextKonstanten.LeerUnboundedString
      then
         return False;
         
      else
         Open (File => DateiLaden,
               Mode => In_File,
               Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => To_Wide_Wide_String (Source => Spielstandname)));

         Wide_Wide_String'Read (Stream (File => DateiLaden),
                                VersionsnummerPrüfung);
      end if;

      if
        VersionsnummerPrüfung = SonstigesKonstanten.Versionsnummer
      then
         null;
         
      elsif
        JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLadeFalscheVersion) = True
      then
         null;
         
      else
         Close (File => DateiLaden);
         return False;
      end if;
      
      -- Hier noch Prüfungen einbauen ob die Werte so korrekt geladen werden und wenn nicht dann abbrechen und auf Standard setzen. äöü
      -- Bei Fehlschlag der Prüfungen dann einen Rückgabewert für das Hauptmenü einbauen. äöü
      -- Das wird wahrscheinlich auch nur mit Exceptions gehen, oder? äöü
      LadezeitenLogik.SpeichernLadenNullsetzen;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
      
      AllgemeinesLaden (DateiLadenExtern => DateiLaden);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      KarteLaden (DateiLadenExtern => DateiLaden);
      
      RassenwerteLaden (DateiLadenExtern => DateiLaden);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Close (File => DateiLaden);
      
      LadezeitenLogik.SpeichernLadenMaximum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;

      return True;
      
   end Laden;
   
   
   
   procedure AllgemeinesLaden
     (DateiLadenExtern : in File_Type)
   is begin
      
      SpielRecords.AllgemeinesRecord'Read (Stream (File => DateiLadenExtern),
                                           Allgemeines);
      
      SchreibeAllgemeines.GanzerEintrag (EintragExtern => Allgemeines);
      
      SpielRecords.RassenbelegungArray'Read (Stream (File => DateiLadenExtern),
                                             Rassenbelegung);
      
      SchreibeRassenbelegung.GanzesArray (ArrayExtern => Rassenbelegung);
      
   end AllgemeinesLaden;
   
   
   
   procedure KarteLaden
     (DateiLadenExtern : in File_Type)
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Karteneinstellungen);
      
      SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);

      EAchseSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop

               WeltkarteRecords.WeltkarteRecord'Read (Stream (File => DateiLadenExtern),
                                                      Karteneintrag);
               
               SchreibeWeltkarte.GanzerEintrag (EintrageExtern    => Karteneintrag,
                                                KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EAchseSchleife;
      
   end KarteLaden;
   
   
   
   procedure RassenwerteLaden
     (DateiLadenExtern : in File_Type)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Rassenwerte (RasseExtern      => RasseSchleifenwert,
                            DateiLadenExtern => DateiLadenExtern);
         end case;
         
      end loop RassenSchleife;
      
   end RassenwerteLaden;
   
   
   
   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLadenExtern),
                                       Grenzen);
      
      SchreibeGrenzen.GanzerEintrag (RasseExtern   => RasseExtern,
                                     EintragExtern => Grenzen);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
            
         EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenExtern),
                                                      Einheit);
         
         SchreibeEinheitenGebaut.GanzerEintrag (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert),
                                                EintragExtern            => Einheit);
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenExtern),
                                              Stadt);
         
         SchreibeStadtGebaut.GanzerEintrag (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert),
                                            EintragExtern          => Stadt);
         
      end loop StadtSchleife;
      
      SpielRecords.WichtigesRecord'Read (Stream (File => DateiLadenExtern),
                                         Wichtiges);
      
      SchreibeWichtiges.GanzerEintrag (RasseExtern   => RasseExtern,
                                       EintragExtern => Wichtiges);
      
      DiplomatieSchleife:
      for RasseDiplomatieSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

         if
           LeseRassenbelegung.Belegung (RasseExtern => RasseDiplomatieSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
           or
             RasseExtern = RasseDiplomatieSchleifenwert
         then
            null;
            
         else
            SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLadenExtern),
                                                Diplomatie);
               
            SchreibeDiplomatie.GanzerEintrag (RasseEinsExtern => RasseExtern,
                                              RasseZweiExtern => RasseDiplomatieSchleifenwert,
                                              EintragExtern   => Diplomatie);
         end if;

      end loop DiplomatieSchleife;
      
      KartenRecords.CursorRecord'Read (Stream (File => DateiLadenExtern),
                                       Cursor);
      
      SchreibeCursor.GanzerEintrag (RasseExtern   => RasseExtern,
                                    EintragExtern => Cursor);
      
   end Rassenwerte;

end LadenLogik;
