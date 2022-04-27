pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartengrundDatentypen;

package ZufallsgeneratorenChaos is

   function ChaoskarteGrund
     return KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
   
   function ChaoskarteFluss
     return KartengrundDatentypen.Karten_Fluss_Enum;
   
   function ChaoskarteRessource
     (WasserLandExtern : in Boolean)
      return KartengrundDatentypen.Karten_Ressourcen_Enum;

   function TotaleChaoskarteGrund
     return KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
   
   function TotaleChaoskarteFluss
     return KartengrundDatentypen.Karten_Fluss_Enum;
   
   function TotaleChaoskarteRessource
     return KartengrundDatentypen.Karten_Ressourcen_Enum;
   
private
      
   RessourceWert : KartengrundDatentypen.Karten_Ressourcen_Enum;
   
   GrundWert : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;

   package WerteWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartengrundDatentypen.Kartengrund_Vorhanden_Enum);
   GrundGewählt : WerteWählenChaoskarte.Generator;
   
   package FlussWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartengrundDatentypen.Karten_Fluss_Enum);
   FlussGewählt : FlussWählenChaoskarte.Generator;
   
   package RessourceWählenChaoskarte is new Ada.Numerics.Discrete_Random (KartengrundDatentypen.Karten_Ressourcen_Enum);
   RessourceGewählt : RessourceWählenChaoskarte.Generator;

end ZufallsgeneratorenChaos;
