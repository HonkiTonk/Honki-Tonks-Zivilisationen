pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten;

with LeseGebaeudeDatenbank, GebaeudeRichtigeUmgebung;

package body KIGebaeudeBauen is

   function GebäudeBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
   is begin
      
      GebäudeBewertet := KIKonstanten.LeerGebäudeIDBewertung;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleRecords.GebäudeVorhandenArray'Range loop
         
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = True
         then
            null;
            
         elsif
           LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                IDExtern    => GebäudeSchleifenwert) = GlobaleKonstanten.LeerForschungAnforderung
           or else
             GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (LeseGebaeudeDatenbank.Anforderungen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                                       IDExtern    => GebäudeSchleifenwert)) = True
         then            
            case
              GebaeudeRichtigeUmgebung.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                  GebäudeIDExtern        => GebäudeSchleifenwert)
            is
               when True =>
                  if
                    GebäudeBewertet = KIKonstanten.LeerGebäudeIDBewertung
                  then
                     GebäudeBewertet := (GebäudeSchleifenwert, 10);
                     
                  elsif
                    GebäudeBewertet.Bewertung < 10
                  then
                     GebäudeBewertet := (GebäudeSchleifenwert, 10);

                  else
                     null;
                  end if;
                  
               when False =>
                  null;
            end case;
            
         else
            null;
         end if;
         
      end loop GebäudeSchleife;
      
      return GebäudeBewertet;
      
   end GebäudeBauen;

end KIGebaeudeBauen;
