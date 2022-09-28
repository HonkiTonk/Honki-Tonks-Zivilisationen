pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtKonstanten;
with GrafikDatentypen;
with TastenbelegungDatentypen;

with StadtbausystemLogik;
with TasteneingabeLogik;
with EinwohnersystemLogik;
with GebaeudeVerkaufenLogik;
with NachGrafiktask;
with MausauswahlLogik;
with StadtEntfernenLogik;
with StadtAllgemeinesLogik;

package body StadtmenueLogik is

   procedure Stadtmenü
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      NachGrafiktask.AktuelleStadt := StadtRasseNummerExtern.Nummer;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Stadtkarte_Enum;
      
      StadtSchleife:
      loop
         
         case
           TasteneingabeLogik.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 WasIstAusgewählt (StadtRasseNummerExtern => StadtRasseNummerExtern) = False
               then
                  null;
                  
               else
                  exit StadtSchleife;
               end if;
               
            when TastenbelegungDatentypen.Bauen_Enum =>
               StadtbausystemLogik.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               
            when TastenbelegungDatentypen.Auflösen_Enum =>
               if
                 StadtEntfernenLogik.StadtAbreißen (StadtRasseNummerExtern => StadtRasseNummerExtern) = True
               then
                  exit StadtSchleife;
                  
               else
                  null;
               end if;

            when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
               StadtAllgemeinesLogik.NeuerStadtname (StadtRasseNummerExtern => StadtRasseNummerExtern);

            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               exit StadtSchleife;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      NachGrafiktask.AktuelleStadt := StadtKonstanten.LeerNummer;
      
   end Stadtmenü;
   
   
   
   function WasIstAusgewählt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      case
        EinwohnersystemLogik.EinwohnerZuweisenEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when True =>
            return False;
            
         when others =>
            Befehlsauswahl := MausauswahlLogik.Stadtbefehle;
      end case;
            
      case
        Befehlsauswahl
      is
         when BefehleDatentypen.Leer_Enum =>
            return False;
            
         when others =>
            return Mausbefehle (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                AuswahlExtern          => Befehlsauswahl);
      end case;
                  
   end WasIstAusgewählt;
   
   
   
   function Mausbefehle
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AuswahlExtern : in BefehleDatentypen.Stadtbefehle_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        AuswahlExtern
      is
         when BefehleDatentypen.Bauen_Enum =>
            StadtbausystemLogik.Bauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when BefehleDatentypen.Verkaufen_Enum =>
            GebaeudeVerkaufenLogik.Verkaufsliste (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when BefehleDatentypen.Umbenennen_Enum =>
            StadtAllgemeinesLogik.NeuerStadtname (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when BefehleDatentypen.Auflösen_Enum =>
            return StadtEntfernenLogik.StadtAbreißen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when others =>
            return True;
      end case;
      
      return False;
      
   end Mausbefehle;

end StadtmenueLogik;
