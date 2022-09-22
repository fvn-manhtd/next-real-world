import { interfaceType } from 'nexus';

const Node = interfaceType({
  name: 'Node',
  definition(t) {
    t.nonNull.string('id');
  },
});

const BaseTypes = [Node];
export default BaseTypes;
