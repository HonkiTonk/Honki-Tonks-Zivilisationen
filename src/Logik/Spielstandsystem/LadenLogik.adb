with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with GrafikDatentypen;
with VerzeichnisKonstanten;
with TextKonstanten;
with KartenKonstanten;
with StadtKonstanten;
with EinheitenKonstanten;
with TextnummernKonstanten;

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
with MeldungFestlegenLogik;

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
            
            PrüfungErfolgreich := Prüfen (DateiLadenExtern => DateiLaden);
         end if;
                  
         Close (File => DateiLaden);
                        
         case
           PrüfungErfolgreich
         is
            when False =>
               MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungUnladbar);
               
            when True =>
               Open (File => DateiLaden,
                     Mode => In_File,
                     Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => To_Wide_Wide_String (Source => Spielstandname)));
               
               Ladevorgang (DateiLadenExtern => DateiLaden);
      
               Close (File => DateiLaden);
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
        KarteLaden (LadenPrüfenExtern => False,
                    DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        AllgemeinesLaden (LadenPrüfenExtern => False,
                          DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      end case;
      
      case
        RassenwerteLaden (LadenPrüfenExtern => False,
                          DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
            return True;
      end case;
      
   end Prüfen;
   
   
   
   procedure Ladevorgang
     (DateiLadenExtern : in File_Type)
   is begin
               
      Leerwert := KarteLaden (LadenPrüfenExtern => True,
                              DateiLadenExtern  => DateiLadenExtern);
               
      Leerwert := AllgemeinesLaden (LadenPrüfenExtern => True,
                                    DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Leerwert := RassenwerteLaden (LadenPrüfenExtern => True,
                                    DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
               
      LadezeitenLogik.SpeichernLadenMaximum;
      
   end Ladevorgang;
   
   
   
   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Karteneinstellungen);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
            
         when False =>
            null;
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
                 LadenPrüfenExtern
               is
                  when True =>
                     SchreibeWeltkarte.GanzerEintrag (EintrageExtern    => Karteneintrag,
                                                      KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                     
                  when False =>
                     null;
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
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SpielRecords.AllgemeinesRecord'Read (Stream (File => DateiLadenExtern),
                                           Allgemeines);
      
      SpielRecords.RassenbelegungArray'Read (Stream (File => DateiLadenExtern),
                                             Rassenbelegung);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeAllgemeines.GanzerEintrag (EintragExtern => Allgemeines);
            SchreibeRassenbelegung.GanzesArray (ArrayExtern => Rassenbelegung);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end AllgemeinesLaden;
   
   
   
   function RassenwerteLaden
     (LadenPrüfenExtern : in Boolean;
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
           True = Rassenwerte (LadenPrüfenExtern => LadenPrüfenExtern,
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
     (LadenPrüfenExtern : in Boolean;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLadenExtern),
                                       Grenzen);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. Grenzen.Einheitengrenze loop
            
         EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenExtern),
                                                      Einheit);
         
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeEinheitenGebaut.GanzerEintrag (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert),
                                                      EintragExtern            => Einheit);
            
            when False =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. Grenzen.Städtegrenze loop
         
         StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenExtern),
                                              Stadt);
         
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeStadtGebaut.GanzerEintrag (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert),
                                                  EintragExtern          => Stadt);
            
            when False =>
               null;
         end case;
         
      end loop StadtSchleife;
            
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
              LadenPrüfenExtern
            is
               when True =>
                  SchreibeDiplomatie.GanzerEintrag (RasseEinsExtern => RasseExtern,
                                                    RasseZweiExtern => RasseDiplomatieSchleifenwert,
                                                    EintragExtern   => Diplomatie);
            
               when False =>
                  null;
            end case;
         end if;

      end loop DiplomatieSchleife;
      
      
      SpielRecords.WichtigesRecord'Read (Stream (File => DateiLadenExtern),
                                         Wichtiges);
      
      KartenRecords.CursorRecord'Read (Stream (File => DateiLadenExtern),
                                       Cursor);
            
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWichtiges.GanzerEintrag (RasseExtern   => RasseExtern,
                                             EintragExtern => Wichtiges);
            SchreibeGrenzen.GanzerEintrag (RasseExtern   => RasseExtern,
                                           EintragExtern => Grenzen);
            SchreibeCursor.GanzerEintrag (RasseExtern   => RasseExtern,
                                          EintragExtern => Cursor);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
      
   end Rassenwerte;

end LadenLogik;
