package body BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung (Rasse, EinheitenPositionInListe : in Integer) is -- Noch einen Gesamtloop einbauen für Bewegung?
   begin
      
      Get_Immediate (Richtung);
      Richtung := To_Lower (Richtung);
              
      case Richtung is
         when 'w' | '8' =>
            YÄnderung := -1;
            XÄnderung := 0;
            
         when 'a' | '4' =>
            XÄnderung := -1;
            YÄnderung := 0;
            
         when 's' | '2' =>
            YÄnderung := 1;
            XÄnderung := 0;
            
         when 'd' | '6'  =>
            XÄnderung := 1;
            YÄnderung := 0;
            
         when '1' =>
            YÄnderung := 1;
            XÄnderung := -1;

         when '3' =>
            YÄnderung := 1;
            XÄnderung := 1;
            
         when '7' =>
            YÄnderung := -1;
            XÄnderung := -1;
            
         when '9' =>
            YÄnderung := -1;
            XÄnderung := 1;            
            
         when others =>
            return;
      end case;
         
      BewegungEinheitenBerechnung (Rasse => Rasse, EinheitenPositionInListe => EinheitenPositionInListe);         
      
   end BewegungEinheitenRichtung;



   procedure BewegungEinheitenBerechnung (Rasse, EinheitenPositionInListe : in Integer) is
   begin

      NeueXPosition := 0;
      Gegner := 0;
      GegnerPosition := 0;
      Gewonnen := True;
      
      if GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung < Karten.Karten'First (1) or GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
         return;

      elsif GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).AktuelleBewegungspunkte = 0 then
         return;

      elsif (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung, GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung).Grund = 2 or 
               (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung, GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung).Grund >= 29 and Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung, GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung).Grund <= 31)) and
        EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).ID).Passierbarkeit = 1 then
         return;

      elsif ((Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung, GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung).Grund < 29 and Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung, GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung).Grund > 31) and
            Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung, GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung).Grund /= 2) and
        EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).ID).Passierbarkeit = 2 then
         return;
         
      elsif GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung < Karten.Karten'First (2) then
         NeueXPosition := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
         
      elsif GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
         NeueXPosition := Karten.Karten'First (2);

      else
         NeueXPosition := GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung;
      end if;

      RasseSchleife:
      for A in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         EinheitenPositionSchleife:
         for B in GlobaleVariablen.EinheitenGebaut'Range (2) loop

            if GlobaleVariablen.EinheitenGebaut (A, B).ID = 0 then
               exit EinheitenPositionSchleife;

            elsif GlobaleVariablen.EinheitenGebaut (A, B).YAchse = GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung and GlobaleVariablen.EinheitenGebaut (A, B).XAchse = NeueXPosition then
               if A = GlobaleVariablen.Rasse then
                  return;
                  
               else
                  Gegner := A;
                  GegnerPosition := B;
                  exit RasseSchleife;
               end if;
               
            else
               null;
            end if;

         end loop EinheitenPositionSchleife;
      end loop RasseSchleife;

      case Gegner is
         when 0 =>
            null;
            
         when others =>
            BereitsImKrieg := Diplomatie.DiplomatischenStatusPrüfen (AngreifendeRasse => Rasse, VerteidigendeRasse => Gegner);
            case BereitsImKrieg is
               when 1 .. 2 =>
                  Wahl := Auswahl.Auswahl (WelcheAuswahl => 11, WelcherText => 18);
                  case Wahl is
                     when -3 =>
                        Angreifen := True;
                        Diplomatie.KriegDurchDirektenAngriff (AngreifendeRasse => Rasse, VerteidigendeRasse => Gegner);
                     
                     when others =>
                        Angreifen := False;
                  end case;
                  
               when -1 =>
                  Angreifen := True;

               when others =>
                  Angreifen := False;
            end case;
         
            case Angreifen is
               when True =>
                  Gewonnen := Kampfsystem.KampfsystemNahkampf (RasseAngriff => Rasse, EinheitenPositionAngriff => EinheitenPositionInListe, RasseVerteidigung => Gegner, EinheitenPositionVerteidigung => GegnerPosition);
               
               when False =>
                  return;
            end case;
      end case;
      
      case Gewonnen is
         when True =>
            if KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung, NeueXPosition).Grund).Passierbarkeit = EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).ID).Passierbarkeit or
              EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).ID).Passierbarkeit = 3 then
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).YAchse := GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung;
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).XAchse := NeueXPosition;
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).AktuelleBewegungspunkte := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).AktuelleBewegungspunkte - 1;
               
               GlobaleVariablen.CursorImSpiel.YAchse := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).YAchse;
               GlobaleVariablen.CursorImSpiel.XAchse := GlobaleVariablen.EinheitenGebaut (Rasse, EinheitenPositionInListe).XAchse;
         
            else
               null;
            end if;
            
         when others =>
            null;
      end case;
      
   end BewegungEinheitenBerechnung;

end BewegungssystemEinheiten;
