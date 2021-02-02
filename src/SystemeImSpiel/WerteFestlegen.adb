with SchleifenPruefungen, KartenDatenbank, VerbesserungenDatenbank;

package body WerteFestlegen is

   procedure KartenfelderBewerten (Generierung : Boolean; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) is
   begin
      
      case Generierung is
         when False =>
            YAchseÄnderungSchleife:
            for YAchseÄnderung in Koordinaten.YAchse - 3 .. Koordinaten.YAchse + 3 loop
               XAchseÄnderungSchleife:
               for XAchseÄnderung in Koordinaten.XAchse - 3 .. Koordinaten.XAchse + 3 loop

                  Kartenwert (Integer (Koordinaten.EAchse)) := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (Koordinaten.EAchse, YAchseÄnderung, XAchseÄnderung),
                                                                                                   Änderung       => (0, 0, 0),
                                                                                                   ZusatzYAbstand => 0);

                  case Kartenwert (Integer (Koordinaten.EAchse)).YAchse is
                     when GlobaleDatentypen.Kartenfeld'First =>
                        exit XAchseÄnderungSchleife;
                        
                     when others =>
                        Karten.Karten (Koordinaten.EAchse, YAchseÄnderung, XAchseÄnderung).Felderwertung := 0;
                        KartenfelderBewertenKleineSchleife (Koordinaten => (Koordinaten.EAchse, YAchseÄnderung, XAchseÄnderung));
                  end case;
            
               end loop XAchseÄnderungSchleife;
            end loop YAchseÄnderungSchleife;
            
         when True =>
            KartenfelderBewertenKleineSchleife (Koordinaten => (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse));
      end case;
      
   end KartenfelderBewerten;
      


   procedure KartenfelderBewertenKleineSchleife (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) is
   begin
              
      BewertungYÄnderungSchleife:
      for BewertungYÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         BewertungXÄnderungSchleife:
         for BewertungXÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
                     
            Kartenwert (Integer (Koordinaten.EAchse)) := SchleifenPruefungen.KartenUmgebung (Koordinaten    => Koordinaten,
                                                                                             Änderung       => (0, BewertungYÄnderung, BewertungXÄnderung),
                                                                                             ZusatzYAbstand => 0);
            
            case Kartenwert (Integer (Koordinaten.EAchse)).YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit BewertungXÄnderungSchleife;
                  
               when others =>
                  if abs (BewertungYÄnderung) = 2 or abs (BewertungXÄnderung) = 2 then
                     BewertungSelbst (Koordinaten         => Koordinaten,
                                      YAchseFeldAufschlag => Kartenwert (Integer (Koordinaten.EAchse)).YAchse,
                                      XAchseFeldAufschlag => Kartenwert (Integer (Koordinaten.EAchse)).XAchse,
                                      Teiler              => 2);

                  elsif abs (BewertungYÄnderung) = 3 or abs (BewertungXÄnderung) = 3 then
                     BewertungSelbst (Koordinaten         => Koordinaten,
                                      YAchseFeldAufschlag => Kartenwert (Integer (Koordinaten.EAchse)).YAchse,
                                      XAchseFeldAufschlag => Kartenwert (Integer (Koordinaten.EAchse)).XAchse,
                                      Teiler              => 3);

                  else
                     BewertungSelbst (Koordinaten         => Koordinaten,
                                      YAchseFeldAufschlag => Kartenwert (Integer (Koordinaten.EAchse)).YAchse,
                                      XAchseFeldAufschlag => Kartenwert (Integer (Koordinaten.EAchse)).XAchse,
                                      Teiler              => 1);
                  end if;
            end case;
                                 
         end loop BewertungXÄnderungSchleife;
      end loop BewertungYÄnderungSchleife;
         
   end KartenfelderBewertenKleineSchleife;
   
   
   
   procedure BewertungSelbst (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord; YAchseFeldAufschlag, XAchseFeldAufschlag : GlobaleDatentypen.KartenfeldPositiv;
                              Teiler : GlobaleDatentypen.LoopRangeMinusDreiZuDrei) is
   begin
      
      Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Felderwertung := Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Felderwertung
        + ((KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Nahrungsgewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Ressourcengewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Geldgewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Wissensgewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Verteidigungsbonus

           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Nahrungsgewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Ressourcengewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Geldgewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Wissensgewinnung
           + KartenDatenbank.KartenListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Verteidigungsbonus

           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Nahrungsbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Ressourcenbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Geldbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Wissensbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Verteidigungsbonus

           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Nahrungsbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Ressourcenbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Geldbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Wissensbonus
           + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (Koordinaten.EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Verteidigungsbonus) / GesamtproduktionStadt (Teiler));
      
   end BewertungSelbst;

end WerteFestlegen;
