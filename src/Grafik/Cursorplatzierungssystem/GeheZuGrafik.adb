with KartenartDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with SystemDatentypen;

with SchreibeCursor;
with LeseGrafiktask;
with SchreibeGrafiktask;

with SichtweitenGrafik;
with KartenkoordinatenberechnungssystemLogik;

package body GeheZuGrafik is

   procedure GeheZuFestlegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
                
      Kartenwert := Koordinatenberechnung (KoordinatenExtern => LeseGrafiktask.GeheZu);
      
      case
        Kartenwert.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => SpeziesExtern,
                                           KoordinatenExtern => LeseGrafiktask.GeheZu);
            
         when others =>
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => SpeziesExtern,
                                           KoordinatenExtern => Kartenwert);
      end case;
      
      SchreibeGrafiktask.GeheZu (KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
      
   end GeheZuFestlegung;
   
   
   
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      KartenwertKoordinatenberechnung.Ebene := KoordinatenExtern.Ebene;
      AktuelleSichtweite := SichtweitenGrafik.SichtbereichLesen;
      SenkrechteÜbergänge := LeseWeltkarteneinstellungen.KartenformSenkrechte;
      WaagerechteÜbergänge := LeseWeltkarteneinstellungen.KartenformWaagerechte;
        
      if
        2 * AktuelleSichtweite.Senkrechte >= LeseWeltkarteneinstellungen.Senkrechte
      then
         KartenwertKoordinatenberechnung.Senkrechte := LeseWeltkarteneinstellungen.Senkrechte / 2;
         
      elsif
        SenkrechteÜbergänge.SenkrechteNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
        and
          SenkrechteÜbergänge.SenkrechteSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           KoordinatenExtern.Senkrechte <= KartenKonstanten.AnfangSenkrechte + AktuelleSichtweite.Senkrechte
         then
            KartenwertKoordinatenberechnung.Senkrechte := KartenKonstanten.AnfangSenkrechte + AktuelleSichtweite.Senkrechte;
            
         elsif
           KoordinatenExtern.Senkrechte >= LeseWeltkarteneinstellungen.Senkrechte - AktuelleSichtweite.Senkrechte
         then
            KartenwertKoordinatenberechnung.Senkrechte := LeseWeltkarteneinstellungen.Senkrechte - AktuelleSichtweite.Senkrechte;
         
         else
            KartenwertKoordinatenberechnung.Senkrechte := KoordinatenExtern.Senkrechte;
         end if;
         
      elsif
        SenkrechteÜbergänge.SenkrechteNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           KoordinatenExtern.Senkrechte <= KartenKonstanten.AnfangSenkrechte + AktuelleSichtweite.Senkrechte
         then
            KartenwertKoordinatenberechnung.Senkrechte := KartenKonstanten.AnfangSenkrechte + AktuelleSichtweite.Senkrechte;
         
         else
            KartenwertKoordinatenberechnung.Senkrechte := KoordinatenExtern.Senkrechte;
         end if;
         
      elsif
        SenkrechteÜbergänge.SenkrechteSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
      then
         if
           KoordinatenExtern.Senkrechte >= LeseWeltkarteneinstellungen.Senkrechte - AktuelleSichtweite.Senkrechte
         then
            KartenwertKoordinatenberechnung.Senkrechte := LeseWeltkarteneinstellungen.Senkrechte - AktuelleSichtweite.Senkrechte;
         
         else
            KartenwertKoordinatenberechnung.Senkrechte := KoordinatenExtern.Senkrechte;
         end if;
         
      else
         KartenwertKoordinatenberechnung.Senkrechte := KoordinatenExtern.Senkrechte;
      end if;
      
      if
        2 * AktuelleSichtweite.Waagerechte >= LeseWeltkarteneinstellungen.Waagerechte
      then
         KartenwertKoordinatenberechnung.Waagerechte := LeseWeltkarteneinstellungen.Waagerechte / 2;
         
      elsif
        WaagerechteÜbergänge.WaagerechteWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
        and
          WaagerechteÜbergänge.WaagerechteOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           KoordinatenExtern.Waagerechte <= KartenKonstanten.AnfangWaagerechte + AktuelleSichtweite.Waagerechte
         then
            KartenwertKoordinatenberechnung.Waagerechte := KartenKonstanten.AnfangWaagerechte + AktuelleSichtweite.Waagerechte;
         
         elsif
           KoordinatenExtern.Waagerechte >= LeseWeltkarteneinstellungen.Waagerechte - AktuelleSichtweite.Waagerechte
         then
            KartenwertKoordinatenberechnung.Waagerechte := LeseWeltkarteneinstellungen.Waagerechte - AktuelleSichtweite.Waagerechte;
         
         else
            KartenwertKoordinatenberechnung.Waagerechte := KoordinatenExtern.Waagerechte;
         end if;
      
      elsif
        WaagerechteÜbergänge.WaagerechteWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           KoordinatenExtern.Waagerechte <= KartenKonstanten.AnfangWaagerechte + AktuelleSichtweite.Waagerechte
         then
            KartenwertKoordinatenberechnung.Waagerechte := KartenKonstanten.AnfangWaagerechte + AktuelleSichtweite.Waagerechte;
         
         else
            KartenwertKoordinatenberechnung.Waagerechte := KoordinatenExtern.Waagerechte;
         end if;
      
      elsif
        WaagerechteÜbergänge.WaagerechteOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
      then
         if
           KoordinatenExtern.Waagerechte >= LeseWeltkarteneinstellungen.Waagerechte - AktuelleSichtweite.Waagerechte
         then
            KartenwertKoordinatenberechnung.Waagerechte := LeseWeltkarteneinstellungen.Waagerechte - AktuelleSichtweite.Waagerechte;
         
         else
            KartenwertKoordinatenberechnung.Waagerechte := KoordinatenExtern.Waagerechte;
         end if;
         
      else
         KartenwertKoordinatenberechnung.Waagerechte := KoordinatenExtern.Waagerechte;
      end if;
      
      return KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KartenwertKoordinatenberechnung,
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung,
                                                                                                                KartenKonstanten.LeerSenkrechteÄnderung,
                                                                                                                KartenKonstanten.LeerWaagerechteÄnderung),
                                                                                         TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
      
   end Koordinatenberechnung;

end GeheZuGrafik;
