with ZufallsgeneratorenHTSEB;

with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body KartengeneratorGebirgeberechnungenLogik is

   function Gebirge
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      GrundÄnderungswert := 0;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteKartengeneratorumgebung'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            if
              SenkrechteSchleifenwert = 0
              and
                WaagerechteSchleifenwert = 0
            then
               exit SenkrechteSchleife;
               
            else
               KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                            TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            end if;
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
                  
            else
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert)
               is
                  when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
                     GrundÄnderungswert := GrundÄnderungswert + 2;
                     
                  when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
                     GrundÄnderungswert := GrundÄnderungswert + 1;
                     
                  when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Eiswasser_Enum'Range =>
                     null;
                     
                  when others =>
                     GrundÄnderungswert := GrundÄnderungswert - 1;
               end case;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      if
        GrundÄnderungswert <= -4
        and
          ZufallsgeneratorenHTSEB.Münzwurf
      then
         return KartenbasisgrundDatentypen.Hügel_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end Gebirge;

end KartengeneratorGebirgeberechnungenLogik;
