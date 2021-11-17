package a is

   case
     Befehl
   is
      when SystemDatentypen.Oben =>
         Änderung := (0, -1, 0);
            
      when SystemDatentypen.Links =>
         Änderung := (0, 0, -1);
            
      when SystemDatentypen.Unten =>
         Änderung := (0, 1, 0);
            
      when SystemDatentypen.Rechts  =>
         Änderung := (0, 0, 1);
            
      when SystemDatentypen.Links_Oben =>
         Änderung := (0, -1, -1);
            
      when SystemDatentypen.Rechts_Oben =>
         Änderung := (0, -1, 1);
            
      when SystemDatentypen.Links_Unten =>
         Änderung := (0, 1, -1);

      when SystemDatentypen.Rechts_Unten =>
         Änderung := (0, 1, 1);
            
      when SystemDatentypen.Ebene_Hoch =>
         Änderung := (1, 0, 0);
            
      when SystemDatentypen.Ebene_Runter =>
         Änderung := (-1, 0, 0);
               
      when SystemDatentypen.Heimatstadt_Ändern =>
         EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         Änderung := KeineÄnderung;
               
      when SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | SystemDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
         AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              BefehlExtern             => Befehl);
               
         case
           AufgabeDurchführen
         is
            when True =>
               return;
               
            when False =>
               Änderung := KeineÄnderung;
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                     TextZeileExtern => 2);
         end case;
               
      when SystemDatentypen.Bauen =>
         NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         Änderung := KeineÄnderung;
               
      when SystemDatentypen.Mausbewegung =>
         if
           BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
         then
            null;
                  
         else
            return;
         end if;
            
      when others =>
         return;
   end case;
         
   if
     Änderung = KeineÄnderung
   then
      BewegungNochMöglich := BewegungEinheiten.NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
   else
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                  ÄnderungExtern    => Änderung);
         
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            BewegungNochMöglich := True;
               
         when others =>
            BewegungNochMöglich := BewegungEinheiten.BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       NeuePositionExtern       => KartenWert);
      end case;
   end if;
         
   case
     BewegungNochMöglich
   is
      when True =>
         null;
               
      when False =>
         return;
   end case;

   Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
   
end a;
