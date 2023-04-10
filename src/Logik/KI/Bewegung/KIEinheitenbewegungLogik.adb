with EinheitenDatentypen;
with KartenRecordKonstanten;
with SpeziesKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseAllgemeines;

with BewegungsberechnungEinheitenLogik;
with EinheitSuchenLogik;
with KampfsystemEinheitenLogik;
with StadtSuchenLogik;
with KampfsystemStadtLogik;
with PassierbarkeitspruefungLogik;
with EinheitenbewegungLogik;
with BewegungspunkteBerechnenLogik;

with KIKonstanten;
with KIDatentypen;

with KIBewegungsplanBerechnenLogik;
with KIBewegungAllgemeinLogik;
with KIBewegungsplanVereinfachenLogik;
with KIEinheitHandlungstestsLogik;

package body KIEinheitenbewegungLogik is
   
   function Bewegung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      Zielkoordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      BewegungSchleife:
      for BewegungSchleifenwert in KIDatentypen.KINotAus'First .. KIKonstanten.SchwierigkeitsgradBewegung (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         case
           LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         is
            when EinheitenKonstanten.LeerBewegungspunkte =>
               if
                 LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = Zielkoordinaten
               then
                  SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             KoordinatenExtern          => KartenRecordKonstanten.LeerKoordinate);
                  SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  
               else
                  null;
               end if;
               
               exit BewegungSchleife;
               
            when others =>
               null;
         end case;
            
         if
           LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = Zielkoordinaten
           or
             Zielkoordinaten = KartenRecordKonstanten.LeerKoordinate
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            exit BewegungSchleife;
            
         elsif
           True = LeseWeltkarte.Sichtbar (KoordinatenExtern => Zielkoordinaten,
                                          SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
           and
             False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                               NeueKoordinatenExtern      => Zielkoordinaten)
         then
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            exit BewegungSchleife;
            
         elsif
           KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                       PlanschrittExtern          => 1)
         then
            case
              KIBewegungsplanBerechnenLogik.BewegungPlanen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
            is
               when True =>
                  null;
                  
               when False =>
                  exit BewegungSchleife;
            end case;
            
         else
            BewegungDurchführen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         end if;
         
      end loop BewegungSchleife;
      
      return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Bewegung;



   procedure BewegungDurchführen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      NeueKoordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             PlanschrittExtern          => 1);
      
      case
        KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern      => NeueKoordinaten,
                                               EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when KIKonstanten.BewegungNormal =>
            BewegtSich (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIKonstanten.Tauschbewegung =>
            -- Hier noch einmal genauer nachprüfen ob es auch wirklich funktioniert. äöü
            EinheitTauschen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                             NeueKoordinatenExtern      => NeueKoordinaten);
            
         when KIKonstanten.KeineBewegung =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when KIKonstanten.BewegungAngriff =>
            Blockiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end BewegungDurchführen;
   
   
   
   procedure EinheitTauschen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
            
      Tauscheinheit := (EinheitSpeziesNummerExtern.Spezies, EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                   KoordinatenExtern => NeueKoordinatenExtern,
                                                                                                                   LogikGrafikExtern => True));
      
      if
        Tauscheinheit.Nummer = EinheitSpeziesNummerExtern.Nummer
      then
         SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         return;
         
      else
         null;
      end if;
      
      case
        EinheitenbewegungLogik.NurTauschen (BewegendeEinheitExtern => EinheitSpeziesNummerExtern,
                                            StehendeEinheitExtern  => Tauscheinheit)
      is
         when True =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => Tauscheinheit);
            BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => Tauscheinheit,
                                                                   NeueKoordinatenExtern      => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                   EinheitentauschExtern      => True);
            BewegtSich (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when False =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end EinheitTauschen;
   
   
   
   procedure BewegtSich
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      Bewegungsschritt := LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                              PlanschrittExtern          => 1);
      
      case
        BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern      => Bewegungsschritt,
                                                       EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when EinheitenKonstanten.LeerBewegungspunkte =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern        => False);
         
         when others =>
            BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                   NeueKoordinatenExtern      => Bewegungsschritt,
                                                                   EinheitentauschExtern      => False);
      
            KIBewegungsplanVereinfachenLogik.BewegungsplanVerschieben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end BewegtSich;
   
   
   
   procedure Blockiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => NeueKoordinaten,
                                                                               LogikGrafikExtern => True);
      FremdeStadt := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => NeueKoordinaten);
      
      if
        FremdeStadt.Spezies /= SpeziesKonstanten.LeerSpezies
        and
          FremdeEinheit.Spezies /= SpeziesKonstanten.LeerSpezies
      then
         -- Evenutell muss hier und weiter unten noch einmal Anpassungen vorgenommen werden, damit bei eimal Waffen alles richtig funktioniert. äöü
         if
           True = KampfsystemStadtLogik.KampfsystemStadt (AngreifendeEinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                          VerteidigendeStadtSpeziesNummerExtern => FremdeStadt)
           and then
             True = KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern   => EinheitSpeziesNummerExtern,
                                                                   VerteidigerExtern => FremdeEinheit)
         then
            BewegtSich (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         else
            null;
         end if;
            
      elsif
        FremdeStadt.Spezies = SpeziesKonstanten.LeerSpezies
      then
         case
           KampfsystemEinheitenLogik.KampfsystemNahkampf (AngreiferExtern   => EinheitSpeziesNummerExtern,
                                                          VerteidigerExtern => FremdeEinheit)
         is
            when True =>
               BewegtSich (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
            when False =>
               null;
         end case;
         
      else
         case
           KampfsystemStadtLogik.KampfsystemStadt (AngreifendeEinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   VerteidigendeStadtSpeziesNummerExtern => FremdeStadt)
         is
            when True =>
               BewegtSich (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
            when False =>
               null;
         end case;
      end if;
         
   end Blockiert;

end KIEinheitenbewegungLogik;
