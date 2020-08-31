package body VerbesserungenDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put_Line (To_Wide_Wide_String (Einlesen.TexteEinlesen (12, ID)));
      
   end Beschreibung;


   
   procedure Verbesserung (Befehl : in Wide_Wide_Character; Rasse, Listenplatz : in Integer) is -- Prüfung einbauen ob die Einheit schon irgendwas tut und nach Abbruch fragen.
   begin

      case GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung is
         when '0' =>
            VerbesserungeFestgelegt (Befehl => Befehl, Rasse => Rasse, Listenplatz => Listenplatz);
            
         when others =>
            Wahl := EinheitenDatenbank.BeschäftigungAbbrechen;
            case Wahl is
               when True =>
                  VerbesserungeFestgelegt (Befehl => Befehl, Rasse => Rasse, Listenplatz => Listenplatz);
                     
               when False =>
                  null;
            end case;
      end case;
      
   end Verbesserung;



   procedure VerbesserungeFestgelegt (Befehl : in Wide_Wide_Character; Rasse, Listenplatz : in Integer) is
   begin

      if Befehl = 'l' and Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungStraße >= 5 and
        Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungStraße <= 19 then
         Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 4);
         return;

      elsif Befehl = 't' and Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 21 then
         Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 4);
         return;

      elsif Befehl = 't' and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 20 or
                                Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 22) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechen; -- Hier eine Funktion für das ersetzen einer Verbesserung und nicht für die Beschäftigung einbauen
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;
      
      elsif Befehl = 'f' and Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 20 then
         Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 4);
         return;

      elsif Befehl = 'f' and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 21 or
                                Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 22) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechen;
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;
      
      elsif Befehl = 'u' and Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 22 then
         Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 4);
         return;

      elsif Befehl = 'u' and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 20 or
                                Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 22) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechen;
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;

      elsif Befehl = 'z' and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 20 or
                                Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet = 21) then
         Wahl := EinheitenDatenbank.BeschäftigungAbbrechen;
         case Wahl is
            when True =>
               null;
                     
            when False =>
               return;
         end case;
         
      elsif Befehl = Space then
         GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBewegungspunkte := 0;
                              
      else
         null;
      end if;
                              
      GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := '0';
      GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung2 := '0';
      GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 0;
      GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit2 := 0;
      
      case Befehl is
         when 'l' => -- Landstraße
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
               when 1 | 3 .. 6 | 8 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;

               when 7 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 6;
               
               when others =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 1);
            end case;
                              
         when 't' => -- Tiefengrabung
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
               when 1 | 3 .. 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 5;

               when 8 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := 'p';
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit2 := 3;
               
               when others =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 1);
            end case;
            
         when 'f' => -- Farm bauen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
               when 3 .. 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 5;

               when 8 .. 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := 'p';
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit2 := 3;
               
               when others =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 1);
            end case;
            
         when 'u' => -- Festung bauen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
               when 1 | 3 .. 6 | 8 .. 28 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;

               when 7 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 5;
               
               when others =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 1);
            end case;
            
         when 'z' => -- Wald aufforsten
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
               when 3 | 6 | 10 .. 28 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;
               
               when others =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 1);
            end case;

         when 'p' => -- Roden-Trockenlegen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
               when 8 | 9 | 32 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigungszeit := 3;
              
               when others =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 1);
            end case;

         when 'v' => -- Verschanzen
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
               when 1 .. 32 =>
                  GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
               
               when others =>
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 2);
            end case;
            
         when 'h' => -- Heilen
            if GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleLebenspunkte = EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).ID).MaximaleLebenspunkte then
               Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 5);
               
            else
               case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund is
                  when 1 .. 32 =>
                     GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung := Befehl;
               
                  when others =>
                     Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 2);
               end case;
            end if;

         when DEL => -- Einheit auflösen
            Wahl := EinheitenDatenbank.EinheitAuflösen;
            case Wahl is
               when True =>
                  EinheitenDatenbank.EinheitEntfernen (Rasse => Rasse, Platznummer => Listenplatz);
                     
               when False =>
                  null;
            end case;
                     
         when others =>
            null;
      end case;
            
   end VerbesserungeFestgelegt;
   


   procedure VerbesserungFertiggestellt (Rasse : in Integer) is
   begin
      
      VerbesserungInArbeitSchleife:
      for A in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         case GlobaleVariablen.EinheitenGebaut (Rasse, A).ID is
            when 0 =>
               exit VerbesserungInArbeitSchleife;
               
            when others =>
               case GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigung is
                  when '0' | 'v' | 'h' => -- Verschanzung muss durch Spieler abgebrochen werden/Heilung wird durch die Heilungsprocedure in der Einheitendatenbank festgelegt
                     null;
               
                  when others =>
                     GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigungszeit := GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigungszeit - 1;
                     if GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigungszeit <= 0 then
                        VerbesserungAngelegt (Rasse => Rasse, Listenplatz => A);

                        case GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigung2 is
                           when '0' =>
                              GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigung := '0';
                              GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigungszeit := 0;

                           when others =>
                              GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigung := GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigung2;
                              GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigung2 := '0';
                              GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigungszeit := GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigungszeit2;
                              GlobaleVariablen.EinheitenGebaut (Rasse, A).AktuelleBeschäftigungszeit2 := 0;
                        end case;
                        
                     else
                        null;
                     end if;
               end case;
         end case;
         
      end loop VerbesserungInArbeitSchleife;
      
   end VerbesserungFertiggestellt;



   procedure VerbesserungAngelegt (Rasse, Listenplatz : in Integer) is
   begin
      
      case GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).AktuelleBeschäftigung is -- Landstraße/Tiefengrabung/Farm/Festung/Wald aufforsten/Roden-Trockenlegen
         when 'l' =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungStraße := 6;
              
         when 't' =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet := 21;
              
         when 'f' =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet := 20;
            
         when 'u' =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).VerbesserungGebiet := 22;
              
         when 'z' =>
            Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund := 8;
              
         when 'p' =>
            case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Hügel is
               when True =>
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund := 6;
                  
               when False =>
                  Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse).Grund := 3;
            end case;
            
         when others =>
            null;
      end case;
      
   end VerbesserungAngelegt;

end VerbesserungenDatenbank;
