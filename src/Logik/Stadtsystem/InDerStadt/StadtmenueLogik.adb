with GrafikDatentypen;

with StadtbausystemLogik;
with TasteneingabeLogik;
with EinwohnersystemLogik;
with GebaeudeVerkaufenLogik;
with NachGrafiktask;
with MausauswahlLogik;
with StadtEntfernenLogik;
with StadtAllgemeinesLogik;
with TastenbelegungDatentypen;

package body StadtmenueLogik is

   procedure Stadtmenü
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      NachGrafiktask.AktuelleStadt := StadtSpeziesNummerExtern.Nummer;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
      
      StadtSchleife:
      loop
         
         case
           TasteneingabeLogik.Stadttaste
         is
            when BefehleDatentypen.Auswählen_Enum =>
               if
                 WasIstAusgewählt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = False
               then
                  null;
                  
               else
                  exit StadtSchleife;
               end if;
               
            when BefehleDatentypen.Stadtkarte_Enum =>
               Stadtkarte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               
            when BefehleDatentypen.Bauen_Enum =>
               StadtbausystemLogik.Bauen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               
            when BefehleDatentypen.Verkaufen_Enum =>
               GebaeudeVerkaufenLogik.Verkaufsliste (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               
            when BefehleDatentypen.Auflösen_Enum =>
               if
                 StadtEntfernenLogik.StadtAbreißen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) = True
               then
                  exit StadtSchleife;
                  
               else
                  null;
               end if;

            when BefehleDatentypen.Umbenennen_Enum =>
               StadtAllgemeinesLogik.NeuerStadtname (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

            when BefehleDatentypen.Verlassen_Enum =>
               exit StadtSchleife;
               
            when BefehleDatentypen.Leer_Stadtbefehle_Enum =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.AktuelleStadt := StadtKonstanten.LeerNummer;
      
   end Stadtmenü;
   
   
   
   function WasIstAusgewählt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      case
        EinwohnersystemLogik.EinwohnerZuweisenEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      is
         when True =>
            return False;
            
         when others =>
            Befehlsauswahl := MausauswahlLogik.Stadtbefehle;
      end case;
            
      case
        Befehlsauswahl
      is
         when BefehleDatentypen.Leer_Stadtbefehle_Enum =>
            return False;
            
         when BefehleDatentypen.Stadtkarte_Enum =>
            Stadtkarte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            return False;
            
         when others =>
            return Mausbefehle (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                AuswahlExtern            => Befehlsauswahl);
      end case;
                  
   end WasIstAusgewählt;
   
   
   
   function Mausbefehle
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AuswahlExtern : in BefehleDatentypen.Stadtbefehle_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        AuswahlExtern
      is
         when BefehleDatentypen.Bauen_Enum =>
            StadtbausystemLogik.Bauen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when BefehleDatentypen.Verkaufen_Enum =>
            GebaeudeVerkaufenLogik.Verkaufsliste (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when BefehleDatentypen.Umbenennen_Enum =>
            StadtAllgemeinesLogik.NeuerStadtname (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when BefehleDatentypen.Auflösen_Enum =>
            return StadtEntfernenLogik.StadtAbreißen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when others =>
            return True;
      end case;
      
      return False;
      
   end Mausbefehle;
   
   
   
   procedure Stadtkarte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      NachGrafiktask.Stadtkarte := True;
      
      StadtkarteSchleife:
      loop
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum =>
               null;
               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               GebaeudeVerkaufenLogik.StadtkarteVerkaufen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
               
            when others =>
               exit StadtkarteSchleife;
         end case;
         
      end loop StadtkarteSchleife;
      
      NachGrafiktask.Stadtkarte := False;
      
   end Stadtkarte;

end StadtmenueLogik;
