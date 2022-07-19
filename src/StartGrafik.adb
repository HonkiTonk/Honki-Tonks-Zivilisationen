pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with ZeitKonstanten;

with NachGrafiktask;
with GrafikTerminal;
with GrafikSFML;
with Fehler;

package body StartGrafik is

   procedure StartGrafik
   is begin
      
      GrafikStartenSchleife:
      while NachGrafiktask.ErzeugeFenster = False loop

         delay ZeitKonstanten.WartezeitGrafik;
         
      end loop GrafikStartenSchleife;
            
      case
        NachGrafiktask.AktuelleDarstellung
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            GrafikTerminal.GrafikTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            GrafikSFML.GrafikSFML;
            
         when others =>
            Fehler.GrafikFehler (FehlermeldungExtern => "StartGrafik.StartGrafik - Ungültige Startdarstellung.");
      end case;
      
   end StartGrafik;

end StartGrafik;
