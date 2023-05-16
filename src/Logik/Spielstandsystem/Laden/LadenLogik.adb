with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with GrafikDatentypen;
with VerzeichnisKonstanten;
with TextKonstanten;
with StadtKonstanten;
with EinheitenKonstanten;
with TextnummernKonstanten;

with SchreibeWichtiges;
with SchreibeGrenzen;
with SchreibeDiplomatie;
with SchreibeCursor;
with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeAllgemeines;
with SchreibeSpeziesbelegung;

with LadezeitenLogik;
with NachGrafiktask;
with SpielstandlisteLogik;
with MeldungFestlegenLogik;
with StandardSpielwerteSetzenLogik;
with LadenKarteLogik;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
-- Wären bei den ganzen Prüfungen weitere exceptions sinnvoll? äöü
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
                  Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => To_Wide_Wide_String (Source => Spielstandname)),
                  Form => "WCEM=8");
            
            PrüfungErfolgreich := Prüfen (DateiLadenExtern => DateiLaden);
         end if;
                  
         Close (File => DateiLaden);
                        
         case
           PrüfungErfolgreich
         is
            when False =>
               MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungUnladbar);
               
            when True =>
               StandardSpielwerteSetzenLogik.Standardspielwerte (EinstellungenBehaltenExtern => True);
               
               Open (File => DateiLaden,
                     Mode => In_File,
                     Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => To_Wide_Wide_String (Source => Spielstandname)),
                     Form => "WCEM=8");
               
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
        LadenKarteLogik.KarteLaden (LadenPrüfenExtern => False,
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
        SpezieswerteLaden (LadenPrüfenExtern => False,
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
               
      Leerwert := LadenKarteLogik.KarteLaden (LadenPrüfenExtern => True,
                                              DateiLadenExtern  => DateiLadenExtern);
               
      Leerwert := AllgemeinesLaden (LadenPrüfenExtern => True,
                                    DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Leerwert := SpezieswerteLaden (LadenPrüfenExtern => True,
                                     DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      SchreibeEinheitenGebaut.Standardbewegungsplan;
      LadezeitenLogik.SpeichernLadenMaximum;
      
   end Ladevorgang;
        
   
   
   function AllgemeinesLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SpielRecords.AllgemeinesRecord'Read (Stream (File => DateiLadenExtern),
                                           Allgemeines);
      
      SpielRecords.SpeziesbelegungArray'Read (Stream (File => DateiLadenExtern),
                                              Speziesbelegung);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeAllgemeines.GanzerEintrag (EintragExtern => Allgemeines);
            SchreibeSpeziesbelegung.GanzesArray (ArrayExtern => Speziesbelegung);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end AllgemeinesLaden;
   
   
   
   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           Speziesbelegung (SpeziesSchleifenwert).Belegung = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
               
         elsif
           True = Spezieswerte (LadenPrüfenExtern => LadenPrüfenExtern,
                                SpeziesExtern     => SpeziesSchleifenwert,
                                DateiLadenExtern  => DateiLadenExtern)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop SpeziesSchleife;
      
      return True;
      
   end SpezieswerteLaden;
   
   
   
   function Spezieswerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
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
               SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert),
                                                      EintragExtern              => Einheit);
            
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
               SchreibeStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                  EintragExtern            => Stadt);
            
            when False =>
               null;
         end case;
         
      end loop StadtSchleife;
            
      DiplomatieSchleife:
      for SpeziesDiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop

         if
           Speziesbelegung (SpeziesDiplomatieSchleifenwert).Belegung = SpeziesDatentypen.Leer_Spieler_Enum
           or
             SpeziesExtern = SpeziesDiplomatieSchleifenwert
         then
            null;
            
         else
            SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLadenExtern),
                                                Diplomatie);
            
            case
              LadenPrüfenExtern
            is
               when True =>
                  SchreibeDiplomatie.GanzerEintrag (SpeziesEinsExtern => SpeziesExtern,
                                                    SpeziesZweiExtern => SpeziesDiplomatieSchleifenwert,
                                                    EintragExtern     => Diplomatie);
            
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
            SchreibeWichtiges.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                             EintragExtern => Wichtiges);
            SchreibeGrenzen.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                           EintragExtern => Grenzen);
            SchreibeCursor.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                          EintragExtern => Cursor);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
      
   end Spezieswerte;

end LadenLogik;
