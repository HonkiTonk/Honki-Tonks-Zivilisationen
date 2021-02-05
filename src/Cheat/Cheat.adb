with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with GlobaleVariablen, Karte, Karten, Eingabe, EinheitenDatenbank;

package body Cheat is

   procedure Menü (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      AktuelleEinheit := 1;
      AktuelleRasse := RasseExtern;
      
      MenüSchleife:
      loop

         Put_Line (Item => "n = nächste Einheit, i = Informationen, s = Sichtbarkeit, r = Rasse ändern, e = Einheit festlegen");
         Put_Line (Item => "g = Geld auf 1_000_000 setzen, t = Technologie, v = Verbesserung, a = Einheitenstatus, b = Grund");
         Get_Immediate (Item => Taste);

         case To_Lower (Item => Taste) is               
            when 'n' => -- Zur nächsten Einheit bewegen, unabhängig von der Rasse/sichtbaren Bereich
               BeliebigeNächsteEinheit (RasseExtern => RasseExtern);

            when 'i' => -- Informationen über die aktuelle Einheit/Stadt/Grund/WasAuchImmer, unabhängig vom sichtbaren Bereich
               Informationen;

            when 's' =>
               Sichtbarkeit (RasseExtern => RasseExtern);

            when 'e' =>
               EinheitFestlegen;

            when 'g' =>
               Geld (RasseExtern => RasseExtern);

            when 't' =>
               Technologie (RasseExtern => RasseExtern);

            when 'v' =>
               VerbesserungFestlegen  (RasseExtern => RasseExtern);
               
            when 'a' =>
               EinheitStatus;
               
            when 'b' =>
               GrundFestlegen (RasseExtern => RasseExtern);
               
            when others =>
               return;
         end case;
         Karte.AnzeigeKarte (RasseExtern => RasseExtern);

      end loop MenüSchleife;
      
   end Menü;


   procedure BeliebigeNächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen) is -- Funktioniert nicht 100%, nochmal drüber schauen wenn Zeit und Lust, da Cheatmenü nicht so wichtig
   begin      
      
      if GlobaleVariablen.EinheitenGebaut (AktuelleRasse, AktuelleEinheit).ID = 0 then
         AktuelleEinheit := 1;
         loop

            case AktuelleRasse is
               when GlobaleDatentypen.RassenImSpielArray'Last =>
                  AktuelleRasse := GlobaleDatentypen.RassenImSpielArray'First;
               
               when others =>
                  AktuelleRasse := AktuelleRasse + 1;
            end case;

            case GlobaleVariablen.RassenImSpiel (AktuelleRasse) is
               when 0 =>
                  null;
                  
               when others =>
                  exit;
            end case;
            
         end loop;
      
      elsif AktuelleEinheit + 1 > GlobaleVariablen.EinheitenGebaut'Last (2) then
         AktuelleEinheit := 1;
         loop

            case AktuelleRasse is
               when GlobaleDatentypen.RassenImSpielArray'Last =>
                  AktuelleRasse := GlobaleDatentypen.RassenImSpielArray'First;
               
               when others =>
                  AktuelleRasse := AktuelleRasse + 1;
            end case;

            case GlobaleVariablen.RassenImSpiel (AktuelleRasse) is
               when 0 =>
                  null;
                  
               when others =>
                  exit;
            end case;
            
         end loop;

      elsif GlobaleVariablen.EinheitenGebaut (AktuelleRasse, AktuelleEinheit + 1).ID = 0 then
         AktuelleEinheit := 1;
         loop

            case AktuelleRasse is
               when GlobaleDatentypen.RassenImSpielArray'Last =>
                  AktuelleRasse := GlobaleDatentypen.RassenImSpielArray'First;
               
               when others =>
                  AktuelleRasse := AktuelleRasse + 1;
            end case;

            case GlobaleVariablen.RassenImSpiel (AktuelleRasse) is
               when 0 =>
                  null;
                  
               when others =>
                  exit;
            end case;
            
         end loop;
         
      else
         AktuelleEinheit := AktuelleEinheit + 1;
      end if;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasse, AktuelleEinheit).AchsenPosition.YAchse;
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasse, AktuelleEinheit).AchsenPosition.XAchse;
      
   end BeliebigeNächsteEinheit;



   procedure Informationen is
   begin
      
      case GlobaleVariablen.FeindlicheInformationenSehen is
         when False =>
            GlobaleVariablen.FeindlicheInformationenSehen := True;
            
         when True =>
            GlobaleVariablen.FeindlicheInformationenSehen := False;
      end case;
   
   end Informationen;



   procedure Sichtbarkeit (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      EbeneSchleife:
      for EAchse in Karten.Karten'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               Karten.Karten (EAchse, YAchse, XAchse).Sichtbar (RasseExtern) := True;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
   end Sichtbarkeit;



   procedure GrundFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      ID := Eingabe.GanzeZahl (Zahlengröße => 2);

      case ID is
         when 1 .. 9 | 31 .. 32 | 35 .. 40 =>
            Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund := GlobaleDatentypen.KartenGrund (ID);

         when 10 .. 13 | 29 .. 30 | 33 =>
            Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource := GlobaleDatentypen.KartenGrund (ID);

         when 14 .. 28 =>
            Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss := GlobaleDatentypen.KartenGrund (ID);
            
         when others =>
            null;
      end case;
      
   end GrundFestlegen;
   
   
   
   procedure EinheitFestlegen is
   begin

      RasseZahl := GlobaleDatentypen.Rassen (Eingabe.GanzeZahl (Zahlengröße => 2));
      Stadt := Eingabe.GanzeZahl (Zahlengröße => 2);
      ID := Eingabe.GanzeZahl (Zahlengröße => 2);
      
      Put_Line (Item => "Einheit festlegen");
      EinheitenDatenbank.EinheitErzeugen (RasseExtern => RasseZahl,
                                          StadtNummer => Stadt,
                                          ID          => ID);
      
   end EinheitFestlegen;
   
   
   
   procedure Geld (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge := 1_000_000;
      
   end Geld;
   
   
   
   procedure Technologie (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      null;
      
   end Technologie;
   
   
   
   procedure VerbesserungFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      ID := Eingabe.GanzeZahl (Zahlengröße => 2);

      case ID is
         when 5 .. 19 =>
            Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße := GlobaleDatentypen.KartenVerbesserung (ID);

         when 20 .. 22 =>
            Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet := GlobaleDatentypen.KartenVerbesserung (ID);
            
         when others =>
            null;
      end case;
      
   end VerbesserungFestlegen;
   
   
   
   procedure EinheitStatus is
   begin
      
      null;
        
   end EinheitStatus;

end Cheat;
