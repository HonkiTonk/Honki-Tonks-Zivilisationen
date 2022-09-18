pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenRecords;
with StadtRecords;
with SpielRecords;
with SpielDatentypen;
with EinheitenRecords;
with TextnummernKonstanten;
with GrafikDatentypen;
with VerzeichnisKonstanten;
with WeltkarteRecords;
with RueckgabeDatentypen;

with Weltkarte;
with LadezeitenLogik;
with JaNeinLogik;
with SpielstandAllgemeinesLogik;
with NachGrafiktask;
with SpielstandlisteLogik;

package body LadenLogik is
   
   function Laden
     return Boolean
   is begin
      
      case
        SpielstandlisteLogik.Spielstandliste.Auswahl
      is
         when RueckgabeDatentypen.Auswahl_Null_Enum =>
            return False;
            
         when others =>
            NameSpielstand := SpielstandAllgemeinesLogik.SpielstandNameErmitteln;
      end case;
            
      case
        NameSpielstand.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        SpielstandAllgemeinesLogik.SpielstandVorhanden (SpielstandnameExtern => NameSpielstand.EingegebenerText)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
      
      Open (File => DateiLaden,
            Mode => In_File,
            Name => VerzeichnisKonstanten.SpielstandStrich & Encode (Item => To_Wide_Wide_String (Source => NameSpielstand.EingegebenerText)));

      Wide_Wide_String'Read (Stream (File => DateiLaden),
                             VersionsnummerPrüfung);

      if
        VersionsnummerPrüfung = SonstigesKonstanten.Versionsnummer
      then
         null;
         
      else
         case
           JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLadeFalscheVersion)
         is
            when True =>
               null;
               
            when False =>
               Close (File => DateiLaden);
               return False;
         end case;
      end if;
      
      LadezeitenLogik.SpeichernLadenNullsetzen;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
      
      Allgemeines (DateiLadenExtern => DateiLaden);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      KarteLaden (DateiLadenExtern => DateiLaden);
      
      RassenwerteLaden (DateiLadenExtern => DateiLaden);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Close (File => DateiLaden);
      
      LadezeitenLogik.SpeichernLadenMaximum;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;

      return True;
      
   end Laden;
   
   
   
   procedure Allgemeines
     (DateiLadenExtern : in File_Type)
   is begin
      
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                       SpielVariablen.Allgemeines.IronmanName);

      Positive'Read (Stream (File => DateiLadenExtern),
                     SpielVariablen.Allgemeines.Rundenanzahl);
      
      Natural'Read (Stream (File => DateiLadenExtern),
                    SpielVariablen.Allgemeines.Rundengrenze);
      
      SpielVariablen.RassenbelegungArray'Read (Stream (File => DateiLadenExtern),
                                                SpielVariablen.Rassenbelegung);
      
      RassenDatentypen.Rassen_Enum'Read (Stream (File => DateiLadenExtern),
                                         SpielVariablen.Allgemeines.RasseAmZugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Read (Stream (File => DateiLadenExtern),
                                                    SpielVariablen.Allgemeines.Schwierigkeitsgrad);
      
      Boolean'Read (Stream (File => DateiLadenExtern),
                    SpielVariablen.Allgemeines.Gewonnen);
      
      Boolean'Read (Stream (File => DateiLadenExtern),
                    SpielVariablen.Allgemeines.Weiterspielen);
      
   end Allgemeines;
   
   
   
   procedure KarteLaden
     (DateiLadenExtern : in File_Type)
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Weltkarte.Karteneinstellungen);

      EAchseSchleife:
      for EAchseSchleifenwert in Weltkarte.KarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop

               WeltkarteRecords.WeltkarteRecord'Read (Stream (File => DateiLadenExtern),
                                                      Weltkarte.Karte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
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
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
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
   is begin
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLadenExtern),
                                       SpielVariablen.Grenzen (RasseExtern));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
            
         EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenExtern),
                                                      SpielVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert));
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenExtern),
                                              SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert));
            
      end loop StadtSchleife;
      
      SpielRecords.WichtigesRecord'Read (Stream (File => DateiLadenExtern),
                                         SpielVariablen.Wichtiges (RasseExtern));
      
      DiplomatieSchleife:
      for RasseDiplomatieSchleifenwert in SpielVariablen.DiplomatieArray'Range (2) loop

         case
           SpielVariablen.Rassenbelegung (RasseDiplomatieSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
                     
            when others =>
               SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLadenExtern),
                                                   SpielVariablen.Diplomatie (RasseExtern, RasseDiplomatieSchleifenwert));
         end case;

      end loop DiplomatieSchleife;
      
      KartenRecords.CursorRecord'Read (Stream (File => DateiLadenExtern),
                                       SpielVariablen.CursorImSpiel (RasseExtern));
      
   end Rassenwerte;

end LadenLogik;
