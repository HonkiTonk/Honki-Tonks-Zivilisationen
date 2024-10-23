with KartenRecordKonstanten;
with KartenartDatentypen;

with KartenkoordinateEbeneBerechnenLogik;
with KartenkoordinateSenkrechteBerechnenLogik;
with KartenkoordinateWaagerechteBerechnenLogik;
with KartenkoordinatenWerteLogik;

package body KartenkoordinatenberechnungssystemLogik is

   -- Zufallsübergänge einbauen? äöü
   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.KartenfeldRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenRecords.KartenfeldNaturalRecord
   is
      use type KartenRecords.KartenfeldNaturalRecord;
   begin
      
      if
        KoordinatenExtern = KartenRecordKonstanten.LeerKoordinate
      then
         return KartenRecordKonstanten.LeerKoordinate;
         
      else
         null;
      end if;
      
      case
        ÄnderungExtern.Ebene
      is
         when KartenKonstanten.LeerEbeneÄnderung =>
            NeueKoordinate (TaskExtern).Ebene := KoordinatenExtern.Ebene;
            
         when others =>
            NeueKoordinate (TaskExtern).Ebene := KartenkoordinateEbeneBerechnenLogik.KartenkoordinateEbeneBerechnen (EbeneExtern         => KoordinatenExtern.Ebene,
                                                                                                                        ÄnderungEbeneExtern => ÄnderungExtern.Ebene,
                                                                                                                        TaskExtern    => TaskExtern);
            
            if
              NeueKoordinate (TaskExtern).Ebene = KartenKonstanten.LeerEbene
            then
               return KartenRecordKonstanten.LeerKoordinate;
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.SenkrechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                               ÜbergangExtern => KartenartDatentypen.Senkrechte_Übergangslos_Enum);
      
      case
        ÄnderungExtern.Senkrechte
      is
         when KartenKonstanten.LeerSenkrechteÄnderung =>
            NeueKoordinate (TaskExtern).Senkrechte := KoordinatenExtern.Senkrechte;
            
         when others =>
            NeueKoordinate (TaskExtern).Senkrechte := KartenkoordinateSenkrechteBerechnenLogik.KartenkoordinateSenkrechteBerechnen (SenkrechteExtern         => KoordinatenExtern.Senkrechte,
                                                                                                                        ÄnderungSenkrechteExtern => ÄnderungExtern.Senkrechte,
                                                                                                                        TaskExtern    => TaskExtern);
      
            if
              NeueKoordinate (TaskExtern).Senkrechte = KartenKonstanten.LeerSenkrechte
            then
               return KartenRecordKonstanten.LeerKoordinate;
            
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.WaagerechteVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                               ÜbergangExtern => KartenartDatentypen.Waagerechte_Übergangslos_Enum);
            
      case
        ÄnderungExtern.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechteÄnderung =>
            NeueKoordinate (TaskExtern).Waagerechte := KoordinatenExtern.Waagerechte;
            
         when others =>
            NeueKoordinate (TaskExtern).Waagerechte := KartenkoordinateWaagerechteBerechnenLogik.KartenkoordinateWaagerechteBerechnen (WaagerechteExtern         => KoordinatenExtern.Waagerechte,
                                                                                                                        ÄnderungWaagerechteExtern => ÄnderungExtern.Waagerechte,
                                                                                                                        TaskExtern    => TaskExtern);
            
            if
              NeueKoordinate (TaskExtern).Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               return KartenRecordKonstanten.LeerKoordinate;
                  
            else
               null;
            end if;
      end case;
      
      case
        KartenkoordinatenWerteLogik.SenkrechteVerschiebungLesen (TaskExtern => TaskExtern)
      is
         when KartenartDatentypen.Senkrechte_Übergangslos_Enum | KartenartDatentypen.Senkrechte_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Senkrechte_Verschobener_Übergang_Enum =>
            NeueKoordinate (TaskExtern).Waagerechte := KartenkoordinateWaagerechteBerechnenLogik.WaagerechteVerschieben (WaagerechteExtern => NeueKoordinate (TaskExtern).Waagerechte);
      end case;
      
      case
        KartenkoordinatenWerteLogik.WaagerechteVerschiebungLesen (TaskExtern => TaskExtern)
      is
         when KartenartDatentypen.Waagerechte_Übergangslos_Enum | KartenartDatentypen.Waagerechte_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Waagerechte_Verschobener_Übergang_Enum =>
            NeueKoordinate (TaskExtern).Senkrechte := KartenkoordinateSenkrechteBerechnenLogik.SenkrechteVerschieben (SenkrechteExtern => NeueKoordinate (TaskExtern).Senkrechte);
      end case;
      
      return NeueKoordinate (TaskExtern);
      
   end Kartenkoordinatenberechnungssystem;

end KartenkoordinatenberechnungssystemLogik;
