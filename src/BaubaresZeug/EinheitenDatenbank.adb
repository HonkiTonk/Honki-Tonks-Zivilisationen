package body EinheitenDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (10, ID)));
      
   end Beschreibung;



   procedure LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse, Platznummer : in Integer) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer).AktuelleLebenspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer).ID).MaximaleLebenspunkte;
      GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer).AktuelleBewegungspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer).ID).MaximaleBewegungspunkte;
      
   end LebenspunkteBewegungspunkteAufMaximumSetzen;



   procedure HeilungBewegungspunkteFürNeueRundeSetzen is
   begin
      
      RassenSchleife:
      for A in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         EinheitenSchleife:
         for B in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (A, B).ID = 0 then
               exit EinheitenSchleife;

            else
               null;
            end if;

            if GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = '0' then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleBewegungspunkte;

            else
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte := 0.0;
            end if;

            if GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 'h' and 
              GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate >= EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte;
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung := '0';
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigungszeit := 0;
                  
            elsif GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 'h' and 
              GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate < EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte := GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate;
               
            else
               null;
            end if;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteFürNeueRundeSetzen;
   


   procedure EinheitErzeugen (YAchse, XAchse, Rasse, ID : in Integer) is
   begin
      
      null;
      
   end EinheitErzeugen;



   procedure EinheitEntfernen (Rasse, Platznummer : in Integer) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer) := ('0', '0' , 0, 0, 0, 0, 0.0, 0, 0, 0, 0);

      for A in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if A <= Platznummer then
            null;
            
         elsif GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer).ID = 0 and A > Platznummer then
            GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer) := GlobaleVariablen.EinheitenGebaut (Rasse, A - 1);
            GlobaleVariablen.EinheitenGebaut (Rasse, A - 1) := ('0', '0', 0, 0, 0, 0, 0.0, 0, 0, 0, 0);
            
         else
            null;
         end if;
         
      end loop;
      
   end EinheitEntfernen;



   procedure Beschäftigung (Arbeit : in Wide_Wide_Character) is
   begin
      
      case Arbeit is
         when 'l' =>            
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 1)));
            
         when 't' =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 2)));
            
         when 'f' =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 3)));
            
         when 'u' =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 4)));
            
         when 'z' =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 5)));

         when 'p' =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 6)));
            
         when 'h' =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 7)));
            
         when 'v' =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 8)));
            
         when others =>
            Put (To_Wide_Wide_String (Einlesen.TexteEinlesen (22, 9)));            
      end case;
      
   end Beschäftigung;



   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Integer) return Boolean is
   begin
      
      Wahl := Auswahl.Auswahl (WelcheAuswahl => WelcheAuswahl, WelcherText => 18);
      case Wahl is
         when -3 =>
            return True;
                     
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenDatenbank;
