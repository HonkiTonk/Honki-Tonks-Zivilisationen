pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TextaccessVariablen;

with GrafikEinstellungenSFML;

package body TextaccesseStandardSetzenSFML is
   
   procedure AllesAufStandard
   is begin
      
      SchriftartSetzen;
      SchriftgrößeSetzen;
      SchriftfarbeSetzen;
      
   end AllesAufStandard;
   
   

   procedure SchriftartSetzen
   is begin
      
      MenüsEinfachAußenSchleife:
      for AußenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (1) loop
         MenüsEinfachInnenSchleife:
         for InnenSchleifenwert in TextaccessVariablen.MenüsEinfachSFMLAccessArray'Range (2) loop
            
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.MenüsEinfachSFMLAccess (AußenSchleifenwert, InnenSchleifenwert),
                                      font => GrafikEinstellungenSFML.SchriftartAccess);
            
         end loop MenüsEinfachInnenSchleife;
      end loop MenüsEinfachAußenSchleife;
      
   end SchriftartSetzen;
   
   
   
   procedure SchriftgrößeSetzen
   is begin
      
      null;
      
   end SchriftgrößeSetzen;
   
   
   
   procedure SchriftfarbeSetzen
   is begin
      
      null;
      
   end SchriftfarbeSetzen;

end TextaccesseStandardSetzenSFML;
