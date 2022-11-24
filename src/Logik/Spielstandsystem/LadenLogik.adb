with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with GrafikDatentypen;
with VerzeichnisKonstanten;
with TextKonstanten;
with KartenKonstanten;
with StadtKonstanten;
with EinheitenKonstanten;

with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;
with SchreibeWichtiges;
with SchreibeGrenzen;
with SchreibeDiplomatie;
with SchreibeCursor;
with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeAllgemeines;
with SchreibeRassenbelegung;

with LadezeitenLogik;
with NachGrafiktask;
with SpielstandlisteLogik;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenLogik is
   
   function Laden
     return Boolean
   is begin
      
      LadenSchleife:
      loop
         
         Spielstandname := SpielstandlisteLogik.Spielstandliste (SpeichernLadenExtern => False);
      
         if
           Spielstandname = TextKonstanten.LeerUnboundedString
         then
            return False;
         
         else
            LadezeitenLogik.SpeichernLadenNullsetzen;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
            
            Open (File => DateiLaden,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => To_Wide_Wide_String (Source => Spielstandname)));
         end if;
               
         case
           Prüfen (DateiLadenExtern => DateiLaden)
         is
            when False =>
               Close (File => DateiLaden);
               
            when True =>
               Leerwert := KarteLaden (PrüfenLadenExtern => False,
                                       DateiLadenExtern  => DateiLaden);
               
               Leerwert := AllgemeinesLaden (PrüfenLadenExtern => False,
                                             DateiLadenExtern  => DateiLaden);
               LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
               Leerwert := RassenwerteLaden (PrüfenLadenExtern => False,
                                             DateiLadenExtern  => DateiLaden);
               LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
               Close (File => DateiLaden);
               
               LadezeitenLogik.SpeichernLadenMaximum;
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;

               return True;
         end case;
         
      end loop LadenSchleife;
      
   end Laden;
   
   
   
   function Prüfen
     (DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      case
        KarteLaden (PrüfenLadenExtern => True,
                    DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        AllgemeinesLaden (PrüfenLadenExtern => True,
                          DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      end case;
      
      case
        RassenwerteLaden (PrüfenLadenExtern => True,
                          DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
            return True;
      end case;
      
   end Prüfen;
   
   
   
   function KarteLaden
     (PrüfenLadenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Karteneinstellungen);
      
      case
        PrüfenLadenExtern
      is
         when False =>
            null;
            
         when True =>
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
      end case;

      EAchseSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. Karteneinstellungen.Kartengröße.XAchse loop

               WeltkarteRecords.WeltkarteRecord'Read (Stream (File => DateiLadenExtern),
                                                      Karteneintrag);
               
               case
                 PrüfenLadenExtern
               is
                  when False =>
                     null;
            
                  when True =>
                     SchreibeWeltkarte.GanzerEintrag (EintrageExtern    => Karteneintrag,
                                                      KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EAchseSchleife;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
      
   end KarteLaden;
     
   
   
   
   function AllgemeinesLaden
     (PrüfenLadenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SpielRecords.AllgemeinesRecord'Read (Stream (File => DateiLadenExtern),
                                           Allgemeines);
      
      SpielRecords.RassenbelegungArray'Read (Stream (File => DateiLadenExtern),
                                             Rassenbelegung);
      
      case
        PrüfenLadenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeAllgemeines.GanzerEintrag (EintragExtern => Allgemeines);
            SchreibeRassenbelegung.GanzesArray (ArrayExtern => Rassenbelegung);
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end AllgemeinesLaden;
   
   
   
   function RassenwerteLaden
     (PrüfenLadenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
          Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
               
         elsif
           True = Rassenwerte (PrüfenLadenExtern => PrüfenLadenExtern,
                               RasseExtern       => RasseSchleifenwert,
                               DateiLadenExtern  => DateiLadenExtern)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop RassenSchleife;
      
      return True;
      
   end RassenwerteLaden;
   
   
   
   function Rassenwerte
     (PrüfenLadenExtern : in Boolean;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLadenExtern),
                                       Grenzen);
      
      case
        PrüfenLadenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeGrenzen.GanzerEintrag (RasseExtern   => RasseExtern,
                                           EintragExtern => Grenzen);
      end case;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. Grenzen.Einheitengrenze loop
            
         EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenExtern),
                                                      Einheit);
         
         case
           PrüfenLadenExtern
         is
            when True =>
               null;
            
            when False =>
               SchreibeEinheitenGebaut.GanzerEintrag (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert),
                                                      EintragExtern            => Einheit);
         end case;
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. Grenzen.Städtegrenze loop
         
         StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenExtern),
                                              Stadt);
         
         case
           PrüfenLadenExtern
         is
            when True =>
               null;
            
            when False =>
               SchreibeStadtGebaut.GanzerEintrag (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert),
                                                  EintragExtern          => Stadt);
         end case;
         
      end loop StadtSchleife;
      
      SpielRecords.WichtigesRecord'Read (Stream (File => DateiLadenExtern),
                                         Wichtiges);
      
      case
        PrüfenLadenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeWichtiges.GanzerEintrag (RasseExtern   => RasseExtern,
                                             EintragExtern => Wichtiges);
      end case;
      
      DiplomatieSchleife:
      for RasseDiplomatieSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

         if
          Rassenbelegung (RasseDiplomatieSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
           or
             RasseExtern = RasseDiplomatieSchleifenwert
         then
            null;
            
         else
            SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLadenExtern),
                                                Diplomatie);
            case
              PrüfenLadenExtern
            is
               when True =>
                  null;
            
               when False =>
                  SchreibeDiplomatie.GanzerEintrag (RasseEinsExtern => RasseExtern,
                                                    RasseZweiExtern => RasseDiplomatieSchleifenwert,
                                                    EintragExtern   => Diplomatie);
            end case;
         end if;

      end loop DiplomatieSchleife;
      
      KartenRecords.CursorRecord'Read (Stream (File => DateiLadenExtern),
                                       Cursor);
      
      case
        PrüfenLadenExtern
      is
         when True =>
            null;
            
         when False =>
            SchreibeCursor.GanzerEintrag (RasseExtern   => RasseExtern,
                                          EintragExtern => Cursor);
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
      
   end Rassenwerte;

end LadenLogik;
