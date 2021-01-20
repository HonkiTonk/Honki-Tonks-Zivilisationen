package body Cheat is

   procedure Menü (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      AktuelleEinheit := 1;
      AktuelleRasse := RasseExtern;
      
      MenüSchleife:
      loop

         Put_Line (Item => "q = Quit, n = nächste Einheit, i = Informationen, s = Sichtbarkeit, r = Rasse ändern, e = Einheit festlegen");
         Get_Immediate (Item => Taste);

         case To_Lower (Item => Taste) is
            when 'q' =>
               return;
               
            when 'n' => -- Zur nächsten Einheit bewegen, unabhängig von der Rasse/sichtbaren Bereich
               BeliebigeNächsteEinheit (RasseExtern => RasseExtern);

            when 'i' => -- Informationen über die aktuelle Einheit/Stadt/Grund/WasAuchImmer, unabhängig vom sichtbaren Bereich
               Informationen;

            when 's' =>
               Sichtbarkeit (RasseExtern => RasseExtern);

            when 'e' =>
               EinheitFestlegen;
               
            when others =>
               null;
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
      
      GlobaleVariablen.FeindlicheInformationenSehen := True;
      
   end Informationen;



   procedure Sichtbarkeit (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      EbeneSchleife:
      for EAchse in Karten.Karten'Range (1) loop
         YAchseSchleife:
         for YAchse in 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchse in 1 .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               Karten.Karten (EAchse, YAchse, XAchse).Sichtbar (RasseExtern) := True;
               
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

      RasseZahl := GlobaleDatentypen.Rassen (Eingabe.GanzeZahl (Zahlengröße => 2));
      Stadt := Eingabe.GanzeZahl (Zahlengröße => 2);
      ID := Eingabe.GanzeZahl (Zahlengröße => 2);
      
      Put_Line (Item => "Einheit festlegen");
      EinheitenDatenbank.EinheitErzeugen (RasseExtern => RasseZahl,
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

end Cheat;
