package body Cheat is

   procedure Menü is
   begin

      AktuelleEinheit := 1;
      AktuelleRasse := GlobaleVariablen.Rasse;
      
      MenüSchleife:
      loop

         Put_Line (Item => "q = Quit, n = nächste Einheit, i = Informationen, s = Sichtbarkeit, r = Rasse ändern, e = Einheit festlegen");
         Get_Immediate (Item => Taste);

         case To_Lower (Item => Taste) is
            when 'q' =>
               return;
               
            when 'n' => -- Zur nächsten Einheit bewegen, unabhängig von der Rasse/sichtbaren Bereich
               BeliebigeNächsteEinheit;

            when 'i' => -- Informationen über die aktuelle Einheit/Stadt/Grund/WasAuchImmer, unabhängig vom sichtbaren Bereich
               Informationen;

            when 's' =>
               Sichtbarkeit;
               
            when 'r' =>
               Rasse;

            when 'e' =>
               EinheitFestlegen;
               
            when others =>
               null;
         end case;
         Karte.AnzeigeKarte;

      end loop MenüSchleife;
      
   end Menü;


   procedure BeliebigeNächsteEinheit is -- Funktioniert nicht 100%, nochmal drüber schauen wenn Zeit und Lust, da Cheatmenü nicht so wichtig
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
      
      GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasse, AktuelleEinheit).AchsenPosition.YAchse;
      GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasse, AktuelleEinheit).AchsenPosition.XAchse;
      
   end BeliebigeNächsteEinheit;



   procedure Informationen is
   begin
      
      GlobaleVariablen.FeindlicheInformationenSehen := True;
      
   end Informationen;



   procedure Sichtbarkeit is
   begin
      
      EbeneSchleife:
      for E in GlobaleDatentypen.Ebene'Range loop
         YAchseSchleife:
         for Y in 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for X in 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               Karten.Karten (E, Y, X).Sichtbar := True;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
   end Sichtbarkeit;



   procedure GrundFestlegen is
   begin
      
      null;
      
   end GrundFestlegen;
   
   
   
   procedure EinheitFestlegen is
   begin

      RasseZahl := Eingabe.GanzeZahl (Zahlengröße => 2);
      Stadt := Eingabe.GanzeZahl (Zahlengröße => 2);
      ID := Eingabe.GanzeZahl (Zahlengröße => 2);
      
      Put_Line (Item => "Einheit festlegen");
      EinheitenDatenbank.EinheitErzeugen (Rasse       => RasseZahl,
                                          StadtNummer => Stadt,
                                          ID          => ID);
      
   end EinheitFestlegen;
   
   
   
   procedure Geld is
   begin
      
      null;
      
   end Geld;
   
   
   
   procedure Technologie is
   begin
      
      null;
      
   end Technologie;
   
   
   
   procedure VerbesserungFestlegen is
   begin
      
      null;
      
   end VerbesserungFestlegen;
   
   
   
   procedure EinheitStatus is
   begin
      
      null;
        
   end EinheitStatus;



   procedure Rasse is
   begin
      
      Put_Line (Item => "Rasse ändern");
      GlobaleVariablen.Rasse := Eingabe.GanzeZahl (Zahlengröße => 2);
      
   end Rasse;

end Cheat;
