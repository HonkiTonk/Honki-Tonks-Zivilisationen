package body EinheitenDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (10, ID)));
      
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

            if GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 0 then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleBewegungspunkte;

            else
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBewegungspunkte := 0.0;
            end if;

            if GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate >= EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte := EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte;
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung := 0;
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigungszeit := 0;
                  
            elsif GlobaleVariablen.EinheitenGebaut (A, B).AktuelleBeschäftigung = 7
              and GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate < EinheitenListe (GlobaleVariablen.EinheitenGebaut (A, B).ID).MaximaleLebenspunkte then
               GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte := GlobaleVariablen.EinheitenGebaut (A, B).AktuelleLebenspunkte + Heilungsrate;
               
            else
               null;
            end if;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end HeilungBewegungspunkteFürNeueRundeSetzen;
   


   procedure EinheitErzeugen (Rasse, Stadtnummer, ID : in Integer) is
   begin

      Position := (GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).YAchse, GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).XAchse);
            
      RasseSchleife:
      for A in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         EinheitenSchleife:
         for B in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (A, B).ID = 0 then
               exit EinheitenSchleife;

            elsif GlobaleVariablen.EinheitenGebaut (A, B).YAchse = GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).YAchse
              and GlobaleVariablen.EinheitenGebaut (A, B).XAchse = GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).XAchse then
               Position := EinheitErstellenPosition (Rasse       => Rasse,
                                                     Stadtnummer => Stadtnummer);
               
            else
               null;
            end if;
            
         end loop EinheitenSchleife;
      end loop RasseSchleife;
      
      if Position = (0, 0) then
         null;
         
      else
         PositionBestimmenSchleife:
         for Einheitenposition in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (Rasse, Einheitenposition).ID /= 0 then
               null;

            else
               GlobaleVariablen.EinheitenGebaut (Rasse, Einheitenposition).ID := ID;
               GlobaleVariablen.EinheitenGebaut (Rasse, Einheitenposition).YAchse := Position.YAchse;
               GlobaleVariablen.EinheitenGebaut (Rasse, Einheitenposition).XAchse := Position.XAchse;
               LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse       => Rasse,
                                                            Platznummer => Einheitenposition);
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).VerbleibendeBauzeit := 0;
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuelleRessourcen := 0;
               GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).AktuellesBauprojekt := 0;
               return;
            end if;
                                                 
         end loop PositionBestimmenSchleife;
      end if;
            
   end EinheitErzeugen;



   function EinheitErstellenPosition (Rasse, Stadtnummer : Integer) return EinheitErstellenRecord is
   begin

      Umkreis := WerteFestlegen.StadtumgebungsgrößeFestlegen (Rasse       => Rasse,
                                                              Stadtnummer => Stadtnummer);
      
      YAchseSchleife:
      for YAchse in -Umkreis .. Umkreis loop
         XAchseSchleife:
         for XAchse in -Umkreis .. Umkreis loop
            
            if YAchse = 0 and XAchse = 0 then
               null;
               
            elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).YAchse + YAchse < Karten.Karten'First (1) or GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               exit XAchseSchleife;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return (0, 0);
      
   end EinheitErstellenPosition;



   procedure EinheitEntfernen (Rasse, Platznummer : in Integer) is
   begin
      
      GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer) := (0, 0, 0, 0, 0, 0, 0.0, 0, 0, 0, 0);

      case Platznummer is
         when GlobaleVariablen.EinheitenGebaut'Last (2) =>
            return;
            
         when others =>
            for A in reverse GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
               if A = Platznummer then
                  return;
            
               elsif GlobaleVariablen.EinheitenGebaut (Rasse, A).ID /= 0 then
                  GlobaleVariablen.EinheitenGebaut (Rasse, Platznummer) := GlobaleVariablen.EinheitenGebaut (Rasse, A);
                  GlobaleVariablen.EinheitenGebaut (Rasse, A) := (0, 0, 0, 0, 0, 0, 0.0, 0, 0, 0, 0);
                  return;
            
               else
                  null;
               end if;
         
            end loop;
      end case;
      
   end EinheitEntfernen;

   

   procedure Beschäftigung (Arbeit : in Integer) is
   begin
      
      case Arbeit is
         when 0 =>
            Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (22, 9)));            
            
         when others =>
            Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (22, Arbeit)));
      end case;
      
   end Beschäftigung;
   


   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen (WelcheAuswahl : in Integer) return Boolean is
   begin
      
      Wahl := Auswahl.Auswahl (WelcheAuswahl => WelcheAuswahl,
                               WelcherText => 18);
      case Wahl is
         when -3 =>
            return True;
                     
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenDatenbank;
