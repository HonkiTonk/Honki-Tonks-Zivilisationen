pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Calendar; use Ada.Calendar;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RueckgabeDatentypen;
with SystemDatentypen;
with KartenRecords;
with StadtRecords;
with SpielRecords;
with SpielDatentypen;
with EinheitenRecords;
with TextKonstanten;
with GrafikDatentypen;

with Karten;
with Ladezeiten;
with Auswahl;
with SpeichernLadenAllgemein;
with InteraktionGrafiktask;

package body Laden is
   
   function Laden
     return Boolean
   is begin
      
      NameSpielstand := SpeichernLadenAllgemein.SpielstandNameErmitteln;
      
      case
        NameSpielstand.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        SpeichernLadenAllgemein.SpielstandVorhanden (SpielstandnameExtern => NameSpielstand.EingegebenerText)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
      
      Open (File => DateiLaden,
            Mode => In_File,
            Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => NameSpielstand.EingegebenerText)));

      Wide_Wide_String'Read (Stream (File => DateiLaden),
                             VersionsnummerPrüfung);

      if
        VersionsnummerPrüfung = SonstigesKonstanten.Versionsnummer
      then
         null;
         
      else
         case
           Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageLadeFalscheVersion)
         is
            when RueckgabeDatentypen.Ja_Enum =>
               null;
               
            when others =>
               Close (File => DateiLaden);
               return False;
         end case;
      end if;
      
      Ladezeiten.SpeichernLadenNullsetzen;
      Ladezeiten.SpeichernLaden (SystemDatentypen.Anfangswert_Enum) := Clock;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
      
      Allgemeines;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      KarteLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      RassenwerteLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Close (File => DateiLaden);
      
      Ladezeiten.SpeichernLadenMaximum;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      Ladezeiten.SpeichernLaden (SystemDatentypen.Endwert_Enum) := Clock;

      return True;
      
   end Laden;
   
   
   
   procedure Allgemeines
   is begin
      
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLaden),
                                       SpielVariablen.Allgemeines.IronmanName);

      Positive'Read (Stream (File => DateiLaden),
                     SpielVariablen.Allgemeines.Rundenanzahl);
      
      Natural'Read (Stream (File => DateiLaden),
                    SpielVariablen.Allgemeines.Rundengrenze);
      
      RassenDatentypen.RassenImSpielArray'Read (Stream (File => DateiLaden),
                                                 SpielVariablen.RassenImSpiel);
      
      RassenDatentypen.Rassen_Enum'Read (Stream (File => DateiLaden),
                                         SpielVariablen.Allgemeines.RasseAmZugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Read (Stream (File => DateiLaden),
                                                    SpielVariablen.Allgemeines.Schwierigkeitsgrad);
      
      Boolean'Read (Stream (File => DateiLaden),
                    SpielVariablen.Allgemeines.Gewonnen);
      
      Boolean'Read (Stream (File => DateiLaden),
                    SpielVariablen.Allgemeines.Weiterspielen);
      
   end Allgemeines;
   
   
   
   procedure KarteLaden
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLaden),
                                                          Karten.Karteneinstellungen);

      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop

               KartenRecords.KartenRecord'Read (Stream (File => DateiLaden),
                                                Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end KarteLaden;
   
   
   
   procedure RassenwerteLaden
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Rassenwerte (RasseExtern => RasseSchleifenwert);
         end case;
         
      end loop RassenSchleife;
      
   end RassenwerteLaden;
   
   
   
   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLaden),
                                          SpielVariablen.Grenzen (RasseExtern));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
            
         EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLaden),
                                                      SpielVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert));
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLaden),
                                              SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert));
            
      end loop StadtSchleife;
      
      SpielRecords.WichtigesRecord'Read (Stream (File => DateiLaden),
                                            SpielVariablen.Wichtiges (RasseExtern));
      
      DiplomatieSchleife:
      for RasseDiplomatieSchleifenwert in SpielVariablen.DiplomatieArray'Range (2) loop

         case
           SpielVariablen.RassenImSpiel (RasseDiplomatieSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
                     
            when others =>
               SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLaden),
                                                      SpielVariablen.Diplomatie (RasseExtern, RasseDiplomatieSchleifenwert));
         end case;

      end loop DiplomatieSchleife;
      
      KartenRecords.CursorRecord'Read (Stream (File => DateiLaden),
                                       SpielVariablen.CursorImSpiel (RasseExtern));
      
   end Rassenwerte;

end Laden;
